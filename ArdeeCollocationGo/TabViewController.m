//
//  TabViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "TabViewController.h"
#import "HomeViewController.h"

@interface TabViewController ()
{
    UIButton *_buttn;
    UIView *_view;
}
@end

@implementation TabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _buttn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self creatCustomTab];
    
}
- (void)creatCustomTab
{
    _view =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    [self.view addSubview:_view];
    for (int i = 0; i < 5; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*64,0, 64, 49);
        NSString *imgStr = [NSString stringWithFormat:@"tab%d",i+1];
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        [_view addSubview:btn];
        [btn addTarget:self action:@selector(tabBtnCilck:) forControlEvents:UIControlEventTouchUpInside];
        if (btn.tag == 0)
        {
            NSString *imgStrs = [NSString stringWithFormat:@"tab%ds",i+1];
            
            _buttn.frame = CGRectMake(i*64,0, 64, 49);
            [_buttn setImage:[UIImage imageNamed:imgStrs] forState:UIControlStateNormal];            
            [_view addSubview:_buttn];
        }
    }
}
- (void)tabBtnCilck: (UIButton *)btn
{
    [_buttn removeFromSuperview];
    NSString *imgStrs = [NSString stringWithFormat:@"tab%ds",btn.tag+1];
    _buttn.frame = CGRectMake(btn.tag*64,0,64,49);
    self.selectedIndex = btn.tag;
    [_buttn setImage:[UIImage imageNamed:imgStrs] forState:UIControlStateNormal];
    [_view addSubview:_buttn];
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
