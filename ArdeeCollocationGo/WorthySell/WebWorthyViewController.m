//
//  WebWorthyViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "WebWorthyViewController.h"

@interface WebWorthyViewController ()

@end

@implementation WebWorthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
}
- (void)initWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    NSString *urlStr = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=%@&title=%@",self.worthyBody.topicContentId,self.worthyBody.title];
     NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodeStr]]];
    [self.view addSubview:webView];
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
