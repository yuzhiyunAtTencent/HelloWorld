//
//  GetAlbumPictureViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2018/1/31.
//  Copyright © 2018年 zhiyunyu. All rights reserved.
//

#import "GetAlbumPictureViewController.h"
#import "UIView+Utils.h"
#import <Aspects.h>

@interface GetAlbumPictureViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UIVisualEffectView *effectView;
@property(nonatomic, strong) UIImageView *avatarImageView;
@property(nonatomic, strong) UIButton *saveCurrentImageToAlbumBtn;

@end

@implementation GetAlbumPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    CGRect backFrame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:backFrame];
        imageView.backgroundColor = [UIColor blueColor];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"pikaqiu" ofType:@"png" inDirectory:@"Image.bundle/home"];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        imageView;
    });
//    self.backgroundImageView.alpha = 0.5;
    [self.view addSubview:self.backgroundImageView];
    
    self.effectView = ({
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        effectView.alpha = 0.5;
        effectView.frame = backFrame;
        effectView;
    });
    [self.view addSubview:self.effectView];
    
    self.avatarImageView = ({
        CGFloat imageViewSize = 100;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - imageViewSize) / 2, 100, imageViewSize, imageViewSize)];
        imageView.backgroundColor = [UIColor blueColor];
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.layer.masksToBounds = YES;
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"pikaqiu" ofType:@"png" inDirectory:@"Image.bundle/home"];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        imageView;
    });
    [self.view addSubview:self.avatarImageView];

    //打开用户交互
    self.avatarImageView.userInteractionEnabled = YES;
    //初始化一个手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarDidTapped:)];
    //为图片添加手势
    [self.avatarImageView addGestureRecognizer:singleTap];
    
    self.saveCurrentImageToAlbumBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 600, 300, 30)];
        [btn setTitle:@"把当前页面转为image 保存到相册" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(_saveCurrentImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:self.saveCurrentImageToAlbumBtn];
    
    self.saveCurrentImageToAlbumBtn.qn_bottom = SCREEN_HEIGHT - 2;
    
    [self aspect_hookSelector:@selector(avatarDidTapped:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        NSLog(@"class = %@: %@", [aspectInfo.instance class], aspectInfo.arguments);
    } error:nil];
}

#pragma mark - Private

- (void)_saveCurrentImageToAlbum {
    UIImage *image = [self.view viewToImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// 保存图片到相册的回调函数
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
}


//头像点击事件
- (void)avatarDidTapped:(UIGestureRecognizer *) gestureRecognizer {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//我的相片 （这种形式会把一张张照片罗列出来）
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [alertController addAction:destructiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark UINavigationControllerDelegate, UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqual:@"public.image"]) {
        UIImage *originImage =
        [info objectForKey:UIImagePickerControllerOriginalImage];
        self.avatarImageView.image = originImage;
        self.backgroundImageView.image = originImage;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([UIDevice currentDevice].systemVersion.floatValue < 11) {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")]) {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.frame.size.width < 42) {
                [viewController.view sendSubviewToBack:obj];
                *stop = YES;
            }
        }];
    }
}
@end
