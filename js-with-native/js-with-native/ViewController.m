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
@property(nonatomic,strong)JSContext *context;
@property(nonatomic,strong)twoViewController *twovc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated{
    //文件管理
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
    [self  loadwebview];

   
}

//创建webview
-(void)loadwebview
{
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

//webview代理方法
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //获取webview中的jscontext，js调用oc
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __weak typeof(self) weakSelf = self;
    
    _context[@"print"] = ^(NSString *str){
        NSLog(@"%@",str);
        if (str.length ==0)
        {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入内容" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf presentViewController:alert animated:YES completion:nil];
                
            });
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                if (([str hasPrefix:@"http://"])||([str hasPrefix:@"https://"])) {

                    
                    
                    
                    _twovc =[[twoViewController alloc] init];
                    _twovc.twourl = str;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [weakSelf presentViewController:_twovc animated:YES completion:nil];
                        
                    });
                    
                  
                }
            }];
            [alert addAction:action];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf presentViewController:alert animated:YES completion:nil];
                
            });
        }
        
    };
    
}


    
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
