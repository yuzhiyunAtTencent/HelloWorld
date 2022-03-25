//
//  SaveVideoToCustomAlbumViewController.m
//  Helloworld
//
//  Created by  yuzhiyun on 2021/10/21.
//  Copyright © 2021 zhiyunyu. All rights reserved.
//

#import "SaveVideoToCustomAlbumViewController.h"
#import <Photos/Photos.h>

@interface SaveVideoToCustomAlbumViewController ()

@end

@implementation SaveVideoToCustomAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    PHAssetCollection *assetCollection = [self createCollectionWithName:@"快影草稿素材"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"VID_20210927_102251_8K" ofType:@"mp4"];
    [self saveVideo:path assetCollection:assetCollection];
}

// 创建相册
- (PHAssetCollection * )createCollectionWithName:(NSString *)name {
    NSString * title = name;
    PHFetchResult<PHAssetCollection *> *collections =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                                                                subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHAssetCollection * createCollection = nil; // 最终要获取的自己创建的相册
    for (PHAssetCollection * collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {    // 如果有自己要创建的相册
            createCollection = collection;
            break;
        }
    }
    
    if (createCollection == nil) {  // 如果没有自己要创建的相册
        // 创建自己要创建的相册
        NSError * error1 = nil;
        __block NSString * createCollectionID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary]  performChangesAndWait:^{
            createCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name].placeholderForCreatedAssetCollection.localIdentifier;
        } error:&error1];
        if (error1) {
            NSLog(@"创建相册失败...");
        }
        // 创建相册之后我们还要获取此相册  因为我们要往进存储相片
        createCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createCollectionID] options:nil].firstObject;
    } else {
        NSLog(@"已经存在这个相册");
    }
    
    return createCollection;
}


- (void)saveVideo:(NSString *)videoPath assetCollection:(PHAssetCollection *)assetCollection {
    NSURL *url = [NSURL fileURLWithPath:videoPath];
    
    // 要保存到系统相册中视频的标识
    __block NSString *localIdentifier;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //请求创建一个Asset
        PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
        //请求编辑相册
        PHAssetCollectionChangeRequest *collectonRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        //为Asset创建一个占位符，放到相册编辑请求中
        PHObjectPlaceholder *placeHolder = [assetRequest placeholderForCreatedAsset];
        //相册中添加视频
        [collectonRequest addAssets:@[placeHolder]];
        
        localIdentifier = placeHolder.localIdentifier;
    } completionHandler:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"保存视频成功!");
        } else {
            NSLog(@"保存视频失败:%@", error);
        }
    }];
}


@end
