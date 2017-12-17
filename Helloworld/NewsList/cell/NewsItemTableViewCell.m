//
//  NewsItemTableViewCell.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "NewsItemTableViewCell.h"

@implementation NewsItemTableViewCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {

        //创建imageView添加到cell中
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beauty.jpg"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 150, 80);
        [self setImageCover:imageView];
        [self addSubview:imageView];
        //创建labelTitle添加到cell中
        UILabel *labelTitle = [[UILabel alloc]init];
        labelTitle.frame=CGRectMake(170, 10, 400, 20);
        [self setLabelTitle:labelTitle];
        [self addSubview:labelTitle];

        
        
    }
    return self;
}
-(void)setImage:(NSString *)img setTitle:(NSString *)title{
    [self.imageCover setImage:[UIImage imageNamed:img]];
    [self.labelTitle setText:title];
}

@end
