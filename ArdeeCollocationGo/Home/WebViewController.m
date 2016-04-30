//
//  WebViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/27.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "WebViewController.h"
#import "HomeViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initNavigationBar];
    [self initWebView];
//    [self changeNavigationBar];
}
- (void)initNavigationBar
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 64)];
    [navigationBar setBarTintColor:[UIColor colorWithRed:220/255.0 green:64/255.0 blue:103/255.0 alpha:1]];
    [self.view addSubview:navigationBar];
    
}
- (void)goBackPage
{
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.indexVC.view.frame = CGRectMake(0, 108, 320, 416);
}
- (void)initWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.bannerUrl]]];
    [self.view addSubview:webView];
}
- (void)changeNavigationBar
{
     HomeViewController *homenaVC = [[UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"home"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(54, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"ico_back"] forState:UIControlStateNormal];
    [homenaVC.navigationController.navigationBar addSubview:backBtn];
    [homenaVC.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
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
