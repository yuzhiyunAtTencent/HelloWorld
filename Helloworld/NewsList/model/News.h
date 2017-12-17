//
//  News.h
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/13.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property NSString * title;
@property NSString * picUrl;
-(News*) initWithPicUrl: (NSString *) picUrl title : (NSString *) title;
@end
