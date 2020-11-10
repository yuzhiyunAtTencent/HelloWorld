#import "DownLoadImageViewController.h"

@interface DownLoadImageViewController ()<NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property(nonatomic, strong) UIImageView *avatarImage;
@property(nonatomic, strong) UIButton *downloadBtn;

@property(nonatomic, strong) NSMutableData *data;
@property(nonatomic, assign) long long datalength;

@end

@implementation DownLoadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = [NSMutableData data];
    
    _avatarImage = ({
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 200)];
        image.backgroundColor = [UIColor grayColor];
        image;
    });
    [self.view addSubview:_avatarImage];
    
    _downloadBtn = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, [UIScreen mainScreen].bounds.size.width - 40, 50)];
        btn.backgroundColor = [UIColor blueColor];
        btn;
    });
    [self.view addSubview:_downloadBtn];
    
    [self.downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)download:(UIGestureRecognizer *)recognizer {
    // 使用代理方法需要设置代理,但是session的delegate属性是只读的,要想设置代理只能通过这种方式创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[[NSOperationQueue alloc] init]];

    // 创建任务
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:
                                                               [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1503922663,533112086&fm=26&gp=0.jpg"]]];
    
    // 启动任务
    [task resume];
    
    [NSThread sleepForTimeInterval:6];
}

#pragma mark NSURLSessionDataDelegate

//处理服务器响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
    completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {

    //这里可以通过NSURLResponse处理状态码之类，还可以获取http响应头信息，比如数据size
    NSLog(@"数据总size = %@", @(response.expectedContentLength));
    self.datalength = response.expectedContentLength;
    
    if (completionHandler) {
        // 允许处理服务器的响应，才会继续接收服务器返回的数据
        completionHandler(NSURLSessionResponseAllow);
    }
}

//处理接收到的数据 （数据量大的时候，会被调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.data appendData:data];
    NSLog(@"当前进度：百分之 %@", @(self.data.length * 1.f / self.datalength * 100));
}

#pragma mark NSURLSessionTaskDelegate

//任务结束
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        //主线程，可以在此更新UI
        NSLog(@"当前线程为： %@",[NSThread currentThread]);
        self.avatarImage.image = [UIImage imageWithData:self.data];
    });
}

@end
