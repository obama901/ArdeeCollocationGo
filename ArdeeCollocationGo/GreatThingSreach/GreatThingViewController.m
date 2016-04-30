//
//  GreatThingViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "GreatThingViewController.h"
#import "GreatTableViewCell.h"
#import "GreatEngine.h"
#import "GreatBody.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "TOWebViewController.h"
#import "SDRefresh.h"

@interface GreatThingViewController ()<UITableViewDelegate,UITableViewDataSource,SDRefreshViewAnimationDelegate>
{
    UITableView *_tableView;
    NSArray *_listDataArr;
}
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation GreatThingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _listDataArr = [[NSArray alloc]init];
    [self putMyNavigationBar];
    [self getData];
    [self initTableView];
    [self setupHeader];
    self.navigationController.hidesBarsOnSwipe = YES;
}
#pragma mark ------设置下拉刷新--
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    
    refreshHeader.delegate = self;
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:_tableView];
    _refreshHeader = refreshHeader;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    //    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    animationView.frame = CGRectMake(30, 45, 40, 40);
    animationView.image = [UIImage imageNamed:@"staticDeliveryStaff"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;
    
    NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                        [UIImage imageNamed:@"deliveryStaff1"],
                        [UIImage imageNamed:@"deliveryStaff2"],
                        [UIImage imageNamed:@"deliveryStaff3"]
                        ];
    _animationView.animationImages = images;
    
    
    UIImageView *boxView = [[UIImageView alloc] init];
    boxView.frame = CGRectMake(150, 10, 15, 8);
    boxView.image = [UIImage imageNamed:@"box"];
    [refreshHeader addSubview:boxView];
    _boxView = boxView;
    
    UILabel *label= [[UILabel alloc] init];
    label.text = @"下拉加载最新数据";
    label.frame = CGRectMake((self.view.bounds.size.width - 200) * 0.5, 5, 200, 20);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [refreshHeader addSubview:label];
    _label = label;
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}
#pragma mark - SDRefreshView Animation Delegate下拉刷新代理方法1--

- (void)refreshView:(SDRefreshView *)refreshView didBecomeNormalStateWithMovingProgress:(CGFloat)progress
{
    refreshView.hidden = NO;
    if (progress == 0) {
        _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        _boxView.hidden = NO;
        _label.text = @"下拉加载最新数据";
        [_animationView stopAnimating];
    }
    
    self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
    self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 85, progress * 35);
    
}
#pragma mark ------下拉刷新代理方法2--
- (void)refreshView:(SDRefreshView *)refreshView didBecomeRefreshingStateWithMovingProgress:(CGFloat)progress
{
    _label.text = @"客官别急，正在加载数据...";
    [UIView animateWithDuration:1.5 animations:^{
        self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
    }];
}
#pragma mark ------下拉刷新代理方法3--
- (void)refreshView:(SDRefreshView *)refreshView didBecomeWillRefreshStateWithMovingProgress:(CGFloat)progress
{
    _boxView.hidden = YES;
    _label.text = @"放开我，我才帮你加载数据";
    _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
    [_animationView startAnimating];
}
#pragma mark ------创建tableView--
- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 324.6)];
    for (int a = 0; a <4; a ++)
    {
        for (int i = 0 ; i < 2; i ++)
        {
            UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            headBtn.frame = CGRectMake(40/3+(140+40/3)*i, 40/3+(64.5+40/3)*a, 140, 64.5);
            headBtn.tag = 2*a+i+10;
            NSString *imgStr = [NSString stringWithFormat:@"ss%d",2*a+i];
            [headBtn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
            [view addSubview:headBtn];
        }
    }
    _tableView.tableHeaderView =view;
    [_tableView registerNib:[UINib nibWithNibName:@"GreatTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"greatCell"];
    [self.view addSubview:_tableView];
}
#pragma mark ------获取数据--
- (void)getData
{
    [GreatEngine getGreatListViewWithComplent:^(NSArray *listArr)
    {
        _listDataArr = listArr;
        [_tableView reloadData];
    }];
}
#pragma mark ------返回一个区有多少单元格--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listDataArr.count;
}
#pragma mark ------返回有多少区--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark ------返回单元格内容--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GreatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"greatCell" forIndexPath:indexPath];
     GreatBody *greatBody = _listDataArr[indexPath.row];
    [cell.listImg setImageWithURL:[NSURL URLWithString:greatBody.pic_url] placeholderImage:[UIImage imageNamed:@"img_ipad"]];
    
    cell.listTitle.text = greatBody.title;
    cell.now_Pic.text = [NSString stringWithFormat:@"￥%@",greatBody.now_price];
    cell.origin_pic.text = [NSString stringWithFormat:@"￥%@",greatBody.origin_price];
    cell.discount.text = [NSString stringWithFormat:@"%@折/包邮",greatBody.discount];
    return cell;
}
#pragma mark ------单元格点击方法--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GreatBody *greatBody = _listDataArr[indexPath.row];
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:[NSString stringWithFormat:@"https://detail.m.tmall.com/item.htm?spm=0.0.0.0.ZoDr2X&id=%@",greatBody.num_iid]];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ----navigationBar的设置
- (void)putMyNavigationBar
{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:220/255.0 green:64/255.0 blue:103/255.0 alpha:1]];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
}
#pragma mark ------返回单元格高度--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
