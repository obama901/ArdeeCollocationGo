//
//  HomeViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeIndexViewController.h"
#import "OtherViewController.h"
#import "WebViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "JkjViewController.h"
#import "TomorrowViewController.h"
#import "CodeHeader.h"
#import "TOWebViewController.h"

#define ScreeFrame [UIScreen mainScreen].bounds
@interface HomeViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSegment];
    [self initFlipTableView];
    [self putMyNavigationBar];
    
}
-(void)initSegment{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreeFrame.size.width, 40)];
    _scrollView.contentSize = CGSizeMake(500, 40);
    _scrollView.showsHorizontalScrollIndicator = NO;
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, 40) withDataArray:[NSArray arrayWithObjects:@"全部",@"数码",@"女装",@"男装",@"家居",@"母婴",@"鞋包",@"配饰",@"美妆",@"美食",@"其它", nil] withFont:15];
    
    self.segment.delegate = self;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.segment];
}
-(void)initFlipTableView
{
    if (!self.controllsArray)
    {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    //创建每个选项的viewController,注意在这些viewController中只能用模态跳转界面
    for (int a = 0; a < 11; a++)
    {
        
        if (a == 0)
        {
            HomeIndexViewController *homeIndexVC = [[HomeIndexViewController alloc]init];
            [self.controllsArray addObject:homeIndexVC];
        } else
        {
            OtherViewController *vc = [[OtherViewController alloc]init];
            vc.c_id = a;
            [self.controllsArray addObject:vc];
        }
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushPage:) name:@"banner跳转" object:nil];
    [center addObserver:self selector:@selector(jkjPage:) name:@"九块九" object:nil];
    [center addObserver:self selector:@selector(tomorrowPage:) name:@"明日预告" object:nil];
    [center addObserver:self selector:@selector(everyDayPage:) name:@"每日推荐" object:nil];
    [center addObserver:self selector:@selector(phoneBill:) name:@"手机充值" object:nil];
    [center addObserver:self selector:@selector(cellDetail:) name:@"HomeCellPush" object:nil];
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark ------banner页面跳转--
- (void)pushPage:(NSNotification *)notification
{
//    WebViewController *webViewVC = [notification.userInfo objectForKey:@"webView"];
    TOWebViewController *webViewVC = [notification.userInfo objectForKey:@"webView"];
//    [webViewVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ------九块九跳转--
- (void)jkjPage:(NSNotification *)notification
{
    NSArray *jkjListArr = [notification.userInfo objectForKey:@"jkjListArr"];
    JkjViewController *jkjVC = [[JkjViewController alloc]init];
    jkjVC.jkjListArr = jkjListArr;
    [self.navigationController pushViewController:jkjVC animated:YES];
}
#pragma mark ------明日预告--
- (void)tomorrowPage:(NSNotification *)notification
{
    TomorrowViewController *tomorrowVC = [[TomorrowViewController alloc]init];
    [self.navigationController pushViewController:tomorrowVC animated:YES];
}
#pragma mark ------每日推荐--
- (void)everyDayPage:(NSNotification *)notification
{
//    WebViewController *webViewVC = [[WebViewController alloc]init];
//    webViewVC.bannerUrl = [NSString stringWithFormat:@"%@?app_id=%@&app_oid=%@&app_version=%@&app_channel=%@&sche=%@&",EVERYDAY_REQUEST,APP_ID,APP_OID,APP_Version,APP_Channel,SCHE];
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@?app_id=%@&app_oid=%@&app_version=%@&app_channel=%@&sche=%@",EVERYDAY_REQUEST,APP_ID,APP_OID,APP_Version,APP_Channel,SCHE]];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ------手机充值--
- (void)phoneBill:(NSNotification *)notification
{
//    WebViewController *webViewVC = [[WebViewController alloc]init];
//    webViewVC.bannerUrl = @"http://h5.m.taobao.com/app/cz/cost.html?pid=mm_25856670_0_0&unid=cvHiXDYH6v62&backHiddenFlag=1&v=0";
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:@"http://h5.m.taobao.com/app/cz/cost.html?pid=mm_25856670_0_0&unid=cvHiXDYH6v62&backHiddenFlag=1&v=0"];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ------cell点击事件--
- (void)cellDetail:(NSNotification *)notification
{
    NSString *urlId = [notification.userInfo objectForKey:@"cellUrl"];
//    WebViewController *webViewVC = [[WebViewController alloc]init];
//    webViewVC.bannerUrl = [NSString stringWithFormat:@"https://h5.m.taobao.com/awp/core/detail.htm?id=%@",urlId];
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:[NSString stringWithFormat:@"https://h5.m.taobao.com/awp/core/detail.htm?id=%@",urlId]];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ----navigationBar的设置
- (void)putMyNavigationBar
{
    self.navigationItem.title = @"九块九包邮";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:220/255.0 green:64/255.0 blue:103/255.0 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];

    UIBarButtonItem *nav_search_btn = [[UIBarButtonItem alloc] init];
    [nav_search_btn setImage:[UIImage imageNamed:@"nav_search"]];
    [nav_search_btn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = nav_search_btn;
    UIBarButtonItem *nav_list_btn = [[UIBarButtonItem alloc]init];
    [nav_list_btn setImage:[UIImage imageNamed:@"nav_list"]];
    self.navigationItem.rightBarButtonItem = nav_list_btn;
    [nav_list_btn setTintColor:[UIColor whiteColor]];
}
- (void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    [self.flipView selectIndex:index];
    
}
- (void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index-1);
    [self.segment selectIndex:index];
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
