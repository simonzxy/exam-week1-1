//
//  twoViewController.m
//  js-with-native
//
//  Created by 朱益达 on 16/7/19.
//  Copyright © 2016年 朱益达. All rights reserved.
//

#import "twoViewController.h"

@interface twoViewController ()
@property(nonatomic,strong)UIWebView *web1;

@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _web1 = [[UIWebView alloc] init];
    CGFloat webW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webH = [UIScreen mainScreen].bounds.size.height;
    _web1.frame = CGRectMake(0, 0, webW, webH);
    NSLog(@"%@",_twourl);
    //判断是否含有前缀为http后缀为.pdf的URL输入
    if ([_twourl containsString:@".pdf"]) {
        [self loadpdf];
        
    }else{
    NSURL *url = [NSURL URLWithString:_twourl];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [_web1 loadRequest:request];
    [self.view addSubview:_web1];
    }
    
 
}
//在此方法中作出相关操作（用NSURLsession进行文件下载缓存）
-(void)loadpdf{
    NSString *pdf = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",pdf);
    NSString *pdfpath =[pdf stringByAppendingPathComponent:@"hello-world.pdf"];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:pdfpath]) {
        NSURL *url = [NSURL URLWithString:@"http://123.59.75.85:8080/yhportal/appClientReport/nationalSalesBrief.pdf"];
     
        NSURLSessionDataTask *dataa = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSURL *urll = [NSURL URLWithString:@"http://123.59.75.85:8080/yhportal/appClientReport/nationalSalesBrief.pdf"];
            NSURLRequest* request1 = [NSURLRequest requestWithURL:urll];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [_web1 loadRequest:request1];
                [self.view addSubview:_web1];
                _web1.scrollView.scrollEnabled = YES;
                
            });
            }];
        [dataa resume];
    }}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
