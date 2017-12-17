//
//  NewsItemTableViewCell.h
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsItemTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageCover;
@property (nonatomic, strong) UILabel *labelTitle;

-(void)setImage:(NSString *)img setTitle:(NSString *)title;
@end
