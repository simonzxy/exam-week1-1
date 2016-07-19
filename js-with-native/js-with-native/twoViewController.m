//
//  twoViewController.m
//  js-with-native
//
//  Created by 朱益达 on 16/7/19.
//  Copyright © 2016年 朱益达. All rights reserved.
//

#import "twoViewController.h"

@interface twoViewController ()


@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *web1 = [[UIWebView alloc] init];
    CGFloat webW = [UIScreen mainScreen].bounds.size.width;
    CGFloat webH = [UIScreen mainScreen].bounds.size.height-20;
    web1.frame = CGRectMake(0, 20, webW, webH);
    NSString *str = [NSString stringWithFormat:@"http://%@",_twourl];
    NSLog(@"%@",str);
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [web1 loadRequest:request];
    [self.view addSubview:web1];
    
 
}

- (void)didReceiveMemoryWarning {
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
