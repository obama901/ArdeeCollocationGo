//
//  WorthySellViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/26.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "WorthySellViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "WorthyContextViewController.h"
#import "WorthyBody.h"
#import "WebWorthyViewController.h"
#import "TOWebViewController.h"
#define ScreeFrame [UIScreen mainScreen].bounds
@interface WorthySellViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>
{
    NSArray *_titleArr;
}
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;
@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation WorthySellViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArr = @[@"最新上架",@"臭美妞",@"生活家",@"骚包男",@"吃不胖",@"魔法镜",@"爱运动",@"熊孩子",@"数码控"];
    [self initSegment];
    [self initFlipTableView];
    [self putMyNavigationBar];
}
-(void)initSegment{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScreeFrame.size.width, 40)];
    _scrollView.contentSize = CGSizeMake(500, 40);
    _scrollView.showsHorizontalScrollIndicator = NO;
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, 40) withDataArray:_titleArr withFont:13];
    
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
    NSArray *tabIdArr = @[@"-1",@"5",@"2",@"4",@"3",@"7",@"6",@"8",@"1"];
    for (int a = 0; a < 9; a++)
    {
        
        
            WorthyContextViewController *worthyConVC = [[WorthyContextViewController alloc]init];
        worthyConVC.tab_id = [tabIdArr[a] integerValue];
            [self.controllsArray addObject:worthyConVC];
        
        
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(jumpPage:) name:@"商品详情" object:nil];
    
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}
- (void)jumpPage:(NSNotification *)notification
{
    WorthyBody *worthyBody = [notification.userInfo objectForKey:@"worthyBody"];

    NSString *urlStr = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=%@&title=%@",worthyBody.topicContentId,worthyBody.title];
    NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:encodeStr];
    [self.navigationController pushViewController:webViewVC animated:YES];
}
#pragma mark ----navigationBar的设置
- (void)putMyNavigationBar
{
    self.navigationItem.title = _titleArr[0];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:220/255.0 green:64/255.0 blue:103/255.0 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
}
- (void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
    [self.flipView selectIndex:index];
    self.navigationItem.title = _titleArr[index];
}
- (void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index-1);
    [self.segment selectIndex:index];
    self.navigationItem.title = _titleArr[index-1];
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
