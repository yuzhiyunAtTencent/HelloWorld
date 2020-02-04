//
//  NewsItemTableViewCell.m
//  Helloworld
//
//  Created by zhiyunyu on 2017/12/6.
//  Copyright © 2017年 zhiyunyu. All rights reserved.
//

#import "NewsItemTableViewCell.h"

@interface NewsItemTableViewCell ()

@property(nonatomic, strong) UIImageView *coverImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation NewsItemTableViewCell

#pragma mark - Override

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setImage:(NSString *)img setTitle:(NSString *)title {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"pikaqiu" ofType:@"png" inDirectory:@"Image.bundle/home"];
    [self.coverImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    [self.titleLabel setText:title];
}

#pragma mark - Accessors

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _coverImageView.layer.cornerRadius = 50;
        _coverImageView.backgroundColor = [UIColor redColor];
        _coverImageView.layer.masksToBounds = YES;
//        _coverImageView.layer.mask
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 400, 20)];
    }
    return _titleLabel;
}

@end
