//
//  QNColorBox.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/3/5.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "QNColorBox.h"

@interface QNColorBox ()

@property(nonatomic, assign) NSInteger lowerIndex;
@property(nonatomic, assign) NSInteger upperIndex;
@property(nonatomic, strong) NSMutableArray *distinctColors;
@property(nonatomic, assign) NSInteger population;
@property(nonatomic, assign) NSInteger minRed;
@property(nonatomic, assign) NSInteger maxRed;
@property(nonatomic, assign) NSInteger minGreen;
@property(nonatomic, assign) NSInteger maxGreen;
@property(nonatomic, assign) NSInteger minBlue;
@property(nonatomic, assign) NSInteger maxBlue;
@property(nonatomic, strong) UIColor *averageColor;

@end

@implementation QNColorBox {
    int *myHist;
}

- (NSInteger)pixelTotalCount {
    return self.population;
}

- (instancetype)initWithLowerIndex:(NSInteger)lowerIndex
                        upperIndex:(NSInteger)upperIndex
                        colorArray:(NSMutableArray *)colorArray
                              hist:(int *)hist {
    self = [super init];
    if (self){
        myHist = hist;
        
        _lowerIndex = lowerIndex;
        _upperIndex = upperIndex;
        _distinctColors = colorArray;
    
        [self fitBox];
    }
    return self;
}

- (NSInteger)getVolume{
    NSInteger volume = (_maxRed - _minRed + 1) * (_maxGreen - _minGreen + 1) *
    (_maxBlue - _minBlue + 1);
    return volume;
}

/**
 * Split this color box at the mid-point along it's longest dimension
 *
 * @return the new ColorBox
 */
- (QNColorBox*)splitBox{
    if (![self canSplit]) {
        return nil;
    }
    
    // find median along the longest dimension
    NSInteger splitPoint = [self findSplitPoint];
    
    QNColorBox *newBox = [[QNColorBox alloc] initWithLowerIndex:splitPoint+1
                                                     upperIndex:_upperIndex
                                                     colorArray:_distinctColors
                                                           hist:myHist];
    
    // Now change this box's upperIndex and recompute the color boundaries
    _upperIndex = splitPoint;
    [self fitBox];
    
    return newBox;
}

- (NSInteger)findSplitPoint{
    /*
     * 减色算法：中位切分法 http://km.oa.com/articles/show/367774?kmref=search&from_page=1&no=1
     * 中位切割算法（Median cut） 是Paul Heckbert于1979年提出来的算法。概念上很简单，却也是最知名、应用最为广泛的减色算法
     * https://juejin.im/post/5ab49c3e518825556d0e09e7
     */
    NSInteger longestDimension = [self getLongestColorDimension];
    
    // We need to sort the colors in this box based on the longest color dimension.
    // As we can't use a Comparator to define the sort logic, we modify each color so that
    // it's most significant is the desired dimension
    [self modifySignificantOctetWithDismension:longestDimension lowerIndex:_lowerIndex upperIndex:_upperIndex];
    
    [self sortColorArray];
    
    // Now revert all of the colors so that they are packed as RGB again
    [self modifySignificantOctetWithDismension:longestDimension lowerIndex:_lowerIndex upperIndex:_upperIndex];

//    modifySignificantOctet(colors, longestDimension, mLowerIndex, mUpperIndex);
    
    NSInteger midPoint = _population / 2;
    for (NSInteger i = _lowerIndex, count = 0; i <= _upperIndex; i++)  {
        NSInteger population = myHist[[_distinctColors[i] intValue]];
        count += population;
        if (count >= midPoint) {
            return i;
        }
    }
    
    return _lowerIndex;
}

// 对_distinctColors数组进行排序，数组内存储的是hist的横坐标，也就是具体的颜色值
- (void)sortColorArray {
    
    // Now sort... Arrays.sort uses a exclusive toIndex so we need to add 1
    
    NSInteger sortCount = (_upperIndex - _lowerIndex) + 1;
    NSInteger sortArray[sortCount];
    NSInteger sortIndex = 0;
    
    // _distinctColors 数组内存储的是hist的横坐标，也就是具体的颜色值。
    for (NSInteger index = _lowerIndex;index<= _upperIndex ;index++){
        sortArray[sortIndex] = [_distinctColors[index] integerValue];
        sortIndex++;
    }
    
    NSInteger arrayLength = sortIndex;
    
    //bubble sort
    for(NSInteger i = 0; i < arrayLength-1; i++)
    {
        BOOL isSorted = YES;
        for(NSInteger j=0; j<arrayLength-1-i; j++)
        {
            if(sortArray[j] > sortArray[j+1])
            {
                isSorted = NO;
                NSInteger temp = sortArray[j];
                sortArray[j] = sortArray[j+1];
                sortArray[j+1]=temp;
            }
        }
        if(isSorted)
            break;
    }
    
    sortIndex = 0;
    for (NSInteger index = _lowerIndex;index<= _upperIndex ;index++){
        _distinctColors[index] = [NSNumber numberWithInteger:sortArray[sortIndex]];
        sortIndex++;
    }
}

/**
 * @return the dimension which this box is largest in
 */
- (NSInteger) getLongestColorDimension {
    NSInteger redLength = _maxRed - _minRed;
    NSInteger greenLength = _maxGreen - _minGreen;
    NSInteger blueLength = _maxBlue - _minBlue;
    
    if (redLength >= greenLength && redLength >= blueLength) {
        return COMPONENT_RED;
    } else if (greenLength >= redLength && greenLength >= blueLength) {
        return COMPONENT_GREEN;
    } else {
        return COMPONENT_BLUE;
    }
}

- (BOOL)canSplit{
    if ((_upperIndex - _lowerIndex) <= 0){
        return NO;
    }
    return YES;
}

- (void)fitBox{
    
    // Reset the min and max to opposite values
    NSInteger minRed, minGreen, minBlue;
    minRed = minGreen = minBlue = 32768;
    NSInteger maxRed, maxGreen, maxBlue;
    maxRed = maxGreen = maxBlue = 0;
    NSInteger count = 0;
    
    for (NSInteger i = _lowerIndex; i <= _upperIndex; i++) {
        NSInteger color = [_distinctColors[i] intValue];
        count += myHist[color];
        
        NSInteger r = [QNColorTransformer quantizedRed:color];
        NSInteger g =  [QNColorTransformer quantizedGreen:color];
        NSInteger b =  [QNColorTransformer quantizedBlue:color];
        
        if (r > maxRed) {
            maxRed = r;
        }
        if (r < minRed) {
            minRed = r;
        }
        if (g > maxGreen) {
            maxGreen = g;
        }
        if (g < minGreen) {
            minGreen = g;
        }
        if (b > maxBlue) {
            maxBlue = b;
        }
        if (b < minBlue) {
            minBlue = b;
        }
    }
    
    _minRed = minRed;
    _maxRed = maxRed;
    _minGreen = minGreen;
    _maxGreen = maxGreen;
    _minBlue = minBlue;
    _maxBlue = maxBlue;
    _population = count;
}

/**
 * Modify the significant octet in a packed color int. Allows sorting based on the value of a
 * single color component. This relies on all components being the same word size.
 *
 * @see QNColorBox#findSplitPoint()
 */
- (void) modifySignificantOctetWithDismension:(NSInteger)dimension
                                   lowerIndex:(NSInteger)lower
                                   upperIndex:(NSInteger)upper {
    switch (dimension) {
        case COMPONENT_RED:
            // Already in RGB, no need to do anything
            break;
        case COMPONENT_GREEN:
            // We need to do a RGB to GRB swap, or vice-versa
            for (NSInteger i = lower; i <= upper; i++) {
                NSInteger color = [_distinctColors[i] intValue];
                NSInteger newColor = [QNColorTransformer quantizedGreen:color] << (QUANTIZE_WORD_WIDTH + QUANTIZE_WORD_WIDTH)
                | [QNColorTransformer quantizedRed:color]  << QUANTIZE_WORD_WIDTH | [QNColorTransformer quantizedBlue:color];
                _distinctColors[i] = [NSNumber numberWithInteger:newColor];
            }
            break;
        case COMPONENT_BLUE:
            // We need to do a RGB to BGR swap, or vice-versa
            for (NSInteger i = lower; i <= upper; i++) {
                NSInteger color = [_distinctColors[i] intValue];
                NSInteger newColor =  [QNColorTransformer quantizedBlue:color] << (QUANTIZE_WORD_WIDTH + QUANTIZE_WORD_WIDTH)
                | [QNColorTransformer quantizedGreen:color]  << QUANTIZE_WORD_WIDTH
                | [QNColorTransformer quantizedRed:color];
                _distinctColors[i] = [NSNumber numberWithInteger:newColor];
            }
            break;
    }
}

- (void)calculateAverageColor {
    // 获取平均颜色，这个逻辑其实就很简单了，而且也很容易想到
    NSInteger redSum = 0;
    NSInteger greenSum = 0;
    NSInteger blueSum = 0;
    NSInteger totalPopulation = 0;

    for (NSInteger i = _lowerIndex; i <= _upperIndex; i++) {
        NSInteger color = [_distinctColors[i] intValue];
        NSInteger colorPopulation = myHist[color];

        totalPopulation += colorPopulation;

        redSum += colorPopulation * [QNColorTransformer quantizedRed:color];
        greenSum += colorPopulation * [QNColorTransformer quantizedGreen:color];
        blueSum += colorPopulation * [QNColorTransformer quantizedBlue:color];
    }

    //in case of totalPopulation equals to 0
    if (totalPopulation <= 0){
        return;
    }

    NSInteger redMean = redSum / totalPopulation;
    NSInteger greenMean = greenSum / totalPopulation;
    NSInteger blueMean = blueSum / totalPopulation;

    redMean = [QNColorTransformer modifyWordWidthWithValue:redMean currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];
    greenMean = [QNColorTransformer modifyWordWidthWithValue:greenMean currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];
    blueMean = [QNColorTransformer modifyWordWidthWithValue:blueMean currentWidth:QUANTIZE_WORD_WIDTH targetWidth:8];

    self.averageColor = [UIColor colorWithRed:(CGFloat)redMean / 255
                                        green:(CGFloat)greenMean / 255
                                         blue:(CGFloat)blueMean / 255
                                        alpha:1];
//    NSInteger rgb888Color = redMean << 2 * 8 | greenMean << 8 | blueMean;
}

- (UIColor *)getAverageColor {
    return self.averageColor;
}

@end
