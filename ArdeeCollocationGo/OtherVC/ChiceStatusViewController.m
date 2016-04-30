//
//  ChiceStatusViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/4.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "ChiceStatusViewController.h"

@interface ChiceStatusViewController ()

@end

@implementation ChiceStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLabel5];
}
- (void)initLabel5
{
    _label5 = [[UILabel alloc]init];
    _label5.bounds = CGRectMake(0, 0, 42, 21);
    if ([self.statusCode isEqualToString:@"美女"])
    {
        _label5.center = _label1.center;
        _label5.text = _label1.text;
    } else if ([self.statusCode isEqualToString:@"辣妈"])
    {
        _label5.center = _label2.center;
        _label5.text = _label2.text;
    } else if ([self.statusCode isEqualToString:@"帅哥"])
    {
        _label5.center = _label3.center;
        _label5.text = _label3.text;
    } else if ([self.statusCode isEqualToString:@"屌丝"])
    {
        _label5.center = _label4.center;
        _label5.text = _label4.text;
    }    
    _label5.textColor = [UIColor whiteColor];
    _label5.font = [UIFont systemFontOfSize:13];
    _label5.textAlignment = NSTextAlignmentCenter;
    _label5.backgroundColor = [UIColor colorWithRed:220/255.0 green:64/255.0 blue:103/255.0 alpha:1];
    _label5.clipsToBounds = YES;
    _label5.layer.cornerRadius = 10;
    [self.view addSubview:_label5];
}
#pragma mark ------出栈页面--
- (IBAction)popPage:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)StatusBtnClick:(UIButton *)sender
{
    
    if (sender.tag==1)
    {
        _label5.center = _label1.center;
        _label5.text = _label1.text;
    }
    else if (sender.tag==2)
    {
        _label5.center = _label2.center;
        _label5.text = _label2.text;
    }
    else if (sender.tag==3)
    {
        _label5.center = _label3.center;
        _label5.text = _label3.text;
    }
    else if (sender.tag==4)
    {
        _label5.center = _label4.center;
        _label5.text = _label4.text;
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:@"身份选择" object:nil userInfo:@{@"tag":[NSString stringWithFormat:@"%d",sender.tag]}];
    [self popPage:sender];
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
