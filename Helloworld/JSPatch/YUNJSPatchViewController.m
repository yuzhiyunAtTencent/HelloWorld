//
//  YUNJSPatchViewController.m
//  Helloworld
//
//  Created by zhiyunyu on 2020/6/18.
//  Copyright © 2020 zhiyunyu. All rights reserved.
//

#import "YUNJSPatchViewController.h"
#import <JSPatch/JPEngine.h>

@interface YUNJSPatchViewController ()

@end

@implementation YUNJSPatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"jspatch" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    
    [self.view addSubview:[self genView]];
}

- (UIView *)genView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
