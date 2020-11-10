//
//  PHPickerViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/9/2.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "TestPHPickerViewController.h"
#import <PhotosUI/PhotosUI.h>

@interface TestPHPickerViewController () <PHPickerViewControllerDelegate>
@property(nonatomic, strong) UIImageView *avatarImageView;
@end

@implementation TestPHPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.avatarImageView = ({
        CGFloat imageViewSize = 100;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - imageViewSize) / 2, 100, imageViewSize, imageViewSize)];
        imageView.backgroundColor = [UIColor blueColor];
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView;
    });
    [self.view addSubview:self.avatarImageView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(p_selectImages)]];
}

- (void)p_selectImages {
    if (@available(iOS 14, *)) {
        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] init];
        configuration.filter = [PHPickerFilter imagesFilter]; // 可配置查询用户相册中文件的类型，支持三种
        configuration.selectionLimit = 0; // 默认为1，为0时表示可多选。
        
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        picker.delegate = self;
        // picker vc，在选完图片后需要在回调中手动 dismiss
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)){
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!results || !results.count) {
        return;
    }
    
    NSItemProvider *itemProvider = results.firstObject.itemProvider;
    if ([itemProvider canLoadObjectOfClass:UIImage.class]) {
        __weak typeof(self) weakSelf = self;
        [itemProvider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
            // 这里是子线程
            if ([object isKindOfClass:UIImage.class]) {
                __strong typeof(self) strongSelf = weakSelf;
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.avatarImageView.image = (UIImage *)object;
                });
            }
        }];
    }
}

@end
