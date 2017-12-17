//
//  News.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/13.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "News.h"

@implementation News

-(News*) initWithPicUrl: (NSString *) picUrl title : (NSString *) title{
    News* news=[[News alloc]init];
    [news setPicUrl:picUrl];
    [news setTitle:title];
    return news;
}
@end
