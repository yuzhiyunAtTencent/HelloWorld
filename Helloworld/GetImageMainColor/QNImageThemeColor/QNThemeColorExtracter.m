//
//  QNThemeColor.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/3/5.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNThemeColorExtracter.h"
#import "QNColorTransformer.h"
#import "QNColorBox.h"
#import "QNColorBoxPriorityQueue.h"

// warning zhiyun

int colorHistGram[32768]; // 2^15   直方图：histogram（目前这个框架还存在一个问题，一次只能处理一个图片，如果我在客户端同时处理两张图片，又是用着同一个全局数组，就bug了，）

@interface QNThemeColorExtracter ()

@property(nonatomic, strong) UIImage *image;
@property(nonatomic, assign) NSInteger pixelCount;
@property(nonatomic, strong) NSMutableArray *distinctColors;
@property(nonatomic, strong) QNColorBoxPriorityQueue *priorityQueue;
@property(nonatomic, strong) NSMutableArray<QNColorItem *> *colorArray;

@end

@implementation QNThemeColorExtracter

- (void)extractColorsFromImage:(UIImage *)image
                    colorBlock:(QNGetColorBlock)colorBlock {
    if (!image) {
        return;
    }
    
    self.image = image;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        // warning zhiyun
        [self clearHistArray];
        
        unsigned char *rawData = [self rawPixelDataFromImage:image];
        if (!rawData || self.pixelCount <= 0){
            // warning zhiyun 出错了
            return;
        }
        
        NSInteger red,green,blue;
        for (int pixelIndex = 0; pixelIndex < self.pixelCount; pixelIndex++){
            
            red   = (NSInteger)rawData[pixelIndex*4+0];
            green = (NSInteger)rawData[pixelIndex*4+1];
            blue  = (NSInteger)rawData[pixelIndex*4+2];
            
            /* 这一步转换的目的，我理解是缩减hist数组的大小，否则hist的size（也就是直方图横坐标最大值）应该是2^(3*8),现在缩减后，hist的size是2^(3*5)
            2^(3*8) 是如何得出的？ 因为颜色有rgb三种嘛，每种占8bit,比如白色 ffffff 就等于 2^24 - 1
             但是为何转换后不会影响结果，这个需要我再研究研究
             */
            
            red = [QNColorTransformer modifyWordWidthWithValue:red currentWidth:8 targetWidth:QUANTIZE_WORD_WIDTH];
            green = [QNColorTransformer modifyWordWidthWithValue:green currentWidth:8 targetWidth:QUANTIZE_WORD_WIDTH];
            blue = [QNColorTransformer modifyWordWidthWithValue:blue currentWidth:8 targetWidth:QUANTIZE_WORD_WIDTH];
            
            NSInteger quantizedColor = red << 2*QUANTIZE_WORD_WIDTH | green << QUANTIZE_WORD_WIDTH | blue;
            colorHistGram[quantizedColor] ++;
        }
        
        free(rawData);
        // length就是hist数组长度，也就是颜色直方图的横坐标最大值
        NSInteger length = sizeof(colorHistGram)/sizeof(colorHistGram[0]);
        
        // 算出不同颜色的种类数量
        
        self.distinctColors = [[NSMutableArray alloc]init];
        for (NSInteger color = 0; color < length ;color++){
            if (colorHistGram[color] > 0){
                [self.distinctColors addObject: [NSNumber numberWithInteger:color]];
            }
        }
        
        // 1、这里还可以优化一下，如果有某个色值的像素点数量大于整张图片的一半，就可以直接返回这个颜色值了
        
        // 2、颜色数量少于16种，非常简单，直接取数量最大的颜色即可，
        if (self.distinctColors.count <= QN_THEHE_COLOR_MAX_COUNT){
            for (NSInteger i = 0;i < self.distinctColors.count ; i++){
                NSInteger color = [_distinctColors[i] integerValue];
                NSInteger population = colorHistGram[color];
                
                NSInteger red = [QNColorTransformer quantizedRed:color];
                NSInteger green = [QNColorTransformer quantizedGreen:color];
                NSInteger blue = [QNColorTransformer quantizedBlue:color];
                
                red = [QNColorTransformer modifyWordWidthWithValue:red currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];
                green = [QNColorTransformer modifyWordWidthWithValue:green currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];
                blue = [QNColorTransformer modifyWordWidthWithValue:blue currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];
                
                // 颜色还原
                color = red << 2 * 8 | green << 8 | blue;
                // warning zhiyun 这是极少数情况，颜色少于16种
            }
        } else {
            // 如果颜色数量大于16，开始中位切分算法，对颜色值进行归类，把相近的颜色归为一类颜色。
            self.priorityQueue = [[QNColorBoxPriorityQueue alloc] init];
            
//             这个变量distinctColorIndex非常多余，其实就是 _distinctColors.count - 1
            QNColorBox *colorBox = [[QNColorBox alloc] initWithLowerIndex:0
                                                               upperIndex:self.distinctColors.count - 1
                                                               colorArray:_distinctColors
                                                                     hist:&colorHistGram];
            
            [self.priorityQueue addColorBox:colorBox];
            
            // 开始进行颜色中位分裂算法
            [self splitBoxes:self.priorityQueue];

            [self calculateAverageColors:self.priorityQueue];
        }
        
        UIColor *imageThemeColor = [self findMaxColorBox:self.priorityQueue];
        [self _sortColorResultByPixelCount];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            colorBlock(imageThemeColor, self.colorArray);
        });
    });
}

- (void)_sortColorResultByPixelCount {
    self.colorArray = [self.colorArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        QNColorItem *color1 = (QNColorItem *)obj1;
        QNColorItem *color2 = (QNColorItem *)obj2;
        
        if (color1.pixelCount > color2.pixelCount) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
}

- (void)calculateAverageColors:(QNColorBoxPriorityQueue *)queue {
    if (!self.colorArray) {
        self.colorArray = [NSMutableArray array];
    }
    
    NSMutableArray *colorBoxArray = [queue getColorBoxArray];
    for (QNColorBox *box in colorBoxArray){
        [box calculateAverageColor];
        
        NSInteger colorPercentOfWholeImage = (NSInteger)([box pixelTotalCount] * 100 / self.pixelCount);
        QNColorItem *colorItem = [[QNColorItem alloc] initWithColor:[box getAverageColor]
                                                            percent:colorPercentOfWholeImage
                                                         pixelCount:[box pixelTotalCount]];
        colorItem.isPureColor = box.isPureColor;
        [self.colorArray addObject:colorItem];
    }
}

- (UIColor *)findMaxColorBox:(QNColorBoxPriorityQueue *)queue {
    NSInteger max = 0;
    QNColorBox *maxColorBox;
    for (QNColorBox *colorBox in [queue getColorBoxArray]){
        NSInteger count = [colorBox pixelTotalCount];
        if (count > max) {
            maxColorBox = colorBox;
            max = count;
        }
    }
    
    return [maxColorBox getAverageColor];
}


- (void)splitBoxes:(QNColorBoxPriorityQueue*)queue {
    while (queue.count < QN_THEHE_COLOR_MAX_COUNT) {
        QNColorBox *colorBox = [queue poll];
        if (colorBox != nil && [colorBox canSplit]) {
            [queue addColorBox:[colorBox splitBox]];
            // 这里一定要重新add,(poll的时候已经移除掉了)因为原先的box被削掉一部分，他在队列中的位置就得发生变化，每次add会重新计算位置
            [queue addColorBox:colorBox];
        } else {
            if (colorBox) {
                // 当box内部只有一个像素点的时候，[colorBox canSplit] 返回NO,要记得重新add进queue,否则就丢失了
                [queue addColorBox:colorBox];
            } else {
                // 找不到可以分裂的box了
                return;
            }
        }
    }
}

- (unsigned char *)rawPixelDataFromImage:(UIImage *)image {
    CGImageRef cgImage = [image CGImage];
    NSUInteger width = CGImageGetWidth(cgImage);
    NSUInteger height = CGImageGetHeight(cgImage);
    
    unsigned char *rawData = (unsigned char *)malloc(height * width * 4);
    
    if (!rawData)
        return NULL;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    CGContextRelease(context);
    
    self.pixelCount = (NSInteger)width * (NSInteger)height;
    
    return rawData;
}

// warning zhiyun
- (void)clearHistArray{
    for (NSInteger i = 0;i<32768;i++){
        colorHistGram[i] = 0;
    }
}

@end
