//
//  PersonCenterViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonTableViewCell.h"
#import "TOWebViewController.h"
#import "ChiceStatusViewController.h"

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView *_tableView;
    NSArray *_imgArr;
    NSArray *_titleArr;
    UIImageView *_headImg;
    UIButton *_headBtn;
    NSString *_statusStr;
}

@end

@implementation PersonCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImgAndTitle];
    [self initTableView];    
    
}
#pragma mark ------创建tableView--
- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [_tableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"personCell"];
    [self putHeadImg];
    _tableView.tableHeaderView = _headImg;
    [self.view addSubview:_tableView];
    _statusStr = @"美女";
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(statusChange:) name:@"身份选择" object:nil];
}
- (void)statusChange:(NSNotification *)notification
{
    NSString *tagStr = [notification.userInfo objectForKey:@"tag"];
    if ([tagStr isEqualToString:@"1"])
    {
        _statusStr = @"美女";
    } else if ([tagStr isEqualToString:@"2"])
    {
        _statusStr = @"辣妈";
    } else if ([tagStr isEqualToString:@"3"])
    {
        _statusStr = @"帅哥";
    } else if ([tagStr isEqualToString:@"4"])
    {
        _statusStr = @"屌丝";
    }
    [_tableView reloadData];
    
}
#pragma mark ------设置tableview的区头--
- (void)putHeadImg
{
    self.navigationController.navigationBarHidden = YES;
    _headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_center_bg"]];
    [_headImg setUserInteractionEnabled:YES];
    _headImg.frame =CGRectMake(0, 0, 320, 124);
    _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headBtn setImage:[UIImage imageNamed:@"ico_center_dis"] forState:UIControlStateNormal];
    _headBtn.bounds = CGRectMake(0, 0, 72, 72);
    _headBtn.center = _headImg.center;
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.bounds = CGRectMake(0, 0, 80, 15);
    loginBtn.center = CGPointMake(_headBtn.center.x, _headBtn.center.y+25);
    [loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_headBtn addTarget:self action:@selector(loginPage:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn addTarget:self action:@selector(loginPage:) forControlEvents:UIControlEventTouchUpInside];
    [_headImg addSubview:loginBtn];
    [_headImg addSubview:_headBtn];
    [_tableView addSubview:_headImg];
}
#pragma mark ------点击头像登陆按钮--
- (void)loginPage:(UIButton *)btn
{
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:@"http://h5.m.taobao.com/my/index.htm?target=present&ttid=400000_21517587@jkjby_iPhone_1.0"];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ------初始化图片数组和标题数组--
- (void)initImgAndTitle
{
    _imgArr = [[NSArray alloc] initWithObjects:@"order",@"cart",@"logistic",@"status",@"clear",@"",@"feedback",@"help", nil];
    _titleArr = [[NSArray alloc]initWithObjects:@"我的订单",@"我的购物车",@"我的物流",@"身份设定",@"清除缓存",@"",@"不爽吐槽",@"常见问题", nil];
}
#pragma mark ------每个区返回多少行--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 3;
    }
    else if (section==1)
    {
        return 2;
    }
    else if (section==2)
    {
        return 2;
    }
    return 0;
}
#pragma mark ------返回区的数量--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark ------返回单元格--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell" forIndexPath:indexPath];
    cell.perImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"btn_center_%@", _imgArr[indexPath.section*3+indexPath.row]]];
    cell.perTitle.text = _titleArr[indexPath.section*3+indexPath.row];
    if (indexPath.section==0)
    {
        if (indexPath.row==1)
        {
            cell.perStatus.text = _statusStr;
        }
    }
    return cell;
}
#pragma mark ------单元格点击方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
        case 0:
            if (indexPath.row==0)
            {
                TOWebViewController *webViewVC = [[TOWebViewController alloc] initWithURLString:@"http://h5.m.taobao.com/awp/mtb/olist.htm?sta=4&target=present&ttid=400000_21517587@jkjby_iPhone_1.0"];
                [self.navigationController pushViewController:webViewVC animated:YES];
            }
            else if (indexPath.row==1)
            {
                TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:@"http://d.m.taobao.com/my_bag.htm?target=present&ttid=400000_21517587@jkjby_iPhone_1.0"];
                [self.navigationController pushViewController:webViewVC animated:YES];
            }
            else if (indexPath.row==2)
            {
                TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:@"http://h5.m.taobao.com/awp/mtb/olist.htm?sta=5&target=present&ttid=400000_21517587@jkjby_iPhone_1.0"];
                [self.navigationController pushViewController:webViewVC animated:YES];
            }
            break;
        case 1:
            if (indexPath.row==0)
            {
                ChiceStatusViewController *statusVC = [[ChiceStatusViewController alloc] init];
                statusVC.statusCode = _statusStr;
                [self.navigationController pushViewController:statusVC animated:YES];
            }
            else
            {
                
            }
            break;
        case 2:
            if (indexPath.row==0)
            {
                
            } else
            {
                TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:@"http://app.api.repaiapp.com/sx/songshijie/jiuweb/problem_i.php"];
                [self.navigationController pushViewController:webViewVC animated:YES];
            }
            break;
        default:
            break;
    }
}
#pragma mark ------返回区脚的高度--
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
#pragma mark ------滚动条滚动时调用的方法--
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (_tableView.contentOffset.y<0)
    {
        _headImg.bounds = CGRectMake(0, 0, 320, 124+(-_tableView.contentOffset.y));
        _headBtn.center = _headImg.center;
    }
//    if (scrollView.contentOffset.y < -200)
//    {
//        CGRect rect = _headImg.frame;
//        rect.origin.y = 200;
//        rect.size.height =  -200 ;
//        rect.origin.x = 200;
//        rect.size.width = 200 + fabs(200)*2;
//        _headImg.frame = rect;
//        
//    }
    
    
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
