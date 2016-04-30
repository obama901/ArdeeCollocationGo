//
//  QuickyValueViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "QuickyValueViewController.h"
#import "OtherViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "QuickyEngine.h"
#import "QuickContextViewController.h"
#import "WebViewController.h"
#import "TOWebViewController.h"
#define ScreeFrame [UIScreen mainScreen].bounds
@interface QuickyValueViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation QuickyValueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSegment];
    [self initFlipTableView];
    [self putMyNavigationBar];
    
}
#pragma mark ------添加segment--
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
            QuickContextViewController *vc = [[QuickContextViewController alloc]init];
            vc.c_id = a;
            [self.controllsArray addObject:vc];
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(quickCellClick:) name:@"QuickCellPush" object:nil];
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
#pragma mark ------cell点击事件--
- (void)quickCellClick:(NSNotification *)notification
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
    self.navigationItem.title = @"超值购";
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
