//
//  KYNDiskSizeReportUtil.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/10/8.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "KYNDiskSizeReportUtil.h"

@implementation KYNDiskSizeReportUtil

int MBUint = 1000 * 1000;
NSString *kYNDiskReportTimeKey = @"kYNDiskReportTimeKey";
NSTimeInterval kYNDiskReportTimeOffset = 24 * 60 * 60;

+ (BOOL)_needReport {
    return YES;
//    NSTimeInterval lastTime = [NSUserDefaults.standardUserDefaults doubleForKey:kYNDiskReportTimeKey];
//    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
//    NSTimeInterval offset = currentTime - lastTime;
//    return offset > kYNDiskReportTimeOffset;
}

+ (void)reportDiskSizeInfo {
    if (![self _needReport]) {
        return;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"VID_20210927_102251_8K" ofType:@"mp4"];
    [NSFileManager.defaultManager copyItemAtPath:path toPath:[NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents/VID_20210927_102251_8K.mp4"] error:NULL];
    
    NSMutableDictionary *sizeDic = [NSMutableDictionary dictionary];
//    [sizeDic setObject:@([UIDevice ks_totalDiskSpace] / MBUint) forKey:@"disk_total_space"];
//    [sizeDic setObject:@([UIDevice ks_freeDiskSpace] / MBUint) forKey:@"disk_free_space"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    NSError *error = nil;
    if (@available(iOS 11.0, *)) {
        NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey,
                                                                 NSURLVolumeAvailableCapacityForOpportunisticUsageKey]
                                                         error:&error];
        if (!results) {
//            DDLogError(@"Error retrieving resource keys: %@\n%@", [error localizedDescription], [error userInfo]);
        } else if (results.count > 0
                   && results[NSURLVolumeAvailableCapacityForImportantUsageKey]
                   && results[NSURLVolumeAvailableCapacityForOpportunisticUsageKey]) {
            [sizeDic setObject:@([results[NSURLVolumeAvailableCapacityForImportantUsageKey] unsignedLongLongValue] / MBUint)
                        forKey:@"disk_free_space_important"];
            [sizeDic setObject:@([results[NSURLVolumeAvailableCapacityForOpportunisticUsageKey] unsignedLongLongValue] / MBUint)
                        forKey:@"disk_free_space_opportunistic"];
        }
    }
    
    NSArray<NSString *> *subDirArray = @[@"Documents", @"Library", @"tmp"];
    __block uint64_t kuaiying_editor_total_size = 0;
    [subDirArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *parentPath = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), obj];
        
        __block uint64_t parentFolderSize = 0;
        NSArray<NSString *> * subDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:parentPath error:NULL];
        [subDirectory enumerateObjectsUsingBlock:^(NSString * _Nonnull subDirPath, NSUInteger idx, BOOL * _Nonnull stop) {
            uint64_t folderSize = [self folderSizeAtPath:[NSString stringWithFormat:@"%@/%@", parentPath, subDirPath]];
            parentFolderSize += folderSize;
            // 上报Documents，Library，tmp的子目录大小
            [sizeDic setObject:@(folderSize) forKey:[NSString stringWithFormat:@"%@_%@", obj, subDirPath]];
        }];
        
        // 上报Documents，Library，tmp的大小
        [sizeDic setObject:@(parentFolderSize) forKey:obj];
        kuaiying_editor_total_size += parentFolderSize;
    }];
    
    // 上报快影的Documents，Library，tmp累计占用的总大小
    [sizeDic setObject:@(kuaiying_editor_total_size) forKey:@"editor_total"];
}

// 获得文件夹磁盘占用size
+ (uint64_t)folderSizeAtPath:(NSString*)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    // 文件夹自身也是占用大小的，比如一个空文件夹占用64byte
    uint64_t folderSize = [self fileSizeAtPath:folderPath];
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / MBUint;
}

// 单个文件的大小
+ (uint64_t)fileSizeAtPath:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end

