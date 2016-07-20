//
//  ViewController.m
//  js-with-native
//
//  Created by 朱益达 on 16/7/19.
//  Copyright © 2016年 朱益达. All rights reserved.
//

#import "ViewController.h"
#import "twoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>



@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)NSString *jsurl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated{
    NSFileManager *mgr = [NSFileManager defaultManager];
    //沙盒document文件夹路径
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _jsurl = [document stringByAppendingPathComponent:@"javascript.html"];
   //判断沙盒是否存在js文件
    if (![mgr fileExistsAtPath:_jsurl]) {
         NSString *path = [[NSBundle mainBundle] pathForResource:@"javascript" ofType:@"html"];
        [mgr copyItemAtPath:path toPath:_jsurl error:nil];
    }
    
    //创建webview
    UIWebView *web = [[UIWebView alloc] init];
    CGFloat webW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webH = [UIScreen mainScreen].bounds.size.height-20;
    web.frame = CGRectMake(0, 20, webW, webH);
    //获取沙盒HTML文件路径
    NSURL* url = [NSURL fileURLWithPath:_jsurl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [web loadRequest:request];
    [self.view addSubview:web];
    web.delegate = self;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *url = request.URL.absoluteString;

    if ([url hasPrefix:@"zhu://"])
    {
        NSString *te =[url substringFromIndex:6];
        NSLog(@"%@",te);
        //判断输入是否为空
        if (te.length==0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:te preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
            if ([te hasPrefix:@"http//"]) {
                NSLog(@"%@---",te);
                NSString *array = [te componentsSeparatedByString:@"//"][1];
                NSLog(@"%@",array);
                twoViewController *twovc =[[twoViewController alloc] init];
                twovc.twourl = array;
                [self presentViewController:twovc animated:YES completion:nil];
                }
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        }}
    return YES;
    
}

@end
