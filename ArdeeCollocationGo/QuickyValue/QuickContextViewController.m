//
//  QuickContextViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "QuickContextViewController.h"
#import "QuickyEngine.h"
#import "HomeCollectionViewCell.h"
#import "QuickyBody.h"
#import "UIImageView+WebCache.h"
#import "SDRefresh.h"

@interface QuickContextViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDRefreshViewAnimationDelegate>
{
    UICollectionView *_collectionView;
    NSArray *_listDataArr;
}
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation QuickContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    _listDataArr = [[NSArray alloc]init];
    
    [self getData];
    [self initCollectionView];
    [self setupHeader];
}
#pragma mark ------设置下拉刷新--
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    
    refreshHeader.delegate = self;
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:_collectionView];
    _refreshHeader = refreshHeader;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    //    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_collectionView reloadData];
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
#pragma mark ------创建collectionView--
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 415) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell1"];
    [self.view addSubview:_collectionView];
    
}
#pragma mark ------接收数据--
- (void)getData
{

    [QuickyEngine getQuickyListWithCid:self.c_id withComplent:^(NSArray *listArr)
    {
        _listDataArr = listArr;
        [_collectionView reloadData];
    }];
}
#pragma mark ------DataSource返回各区有多少条目--
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _listDataArr.count;
}
#pragma mark ------返回有多少区--
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark ------点击单元格方法--
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuickyBody *listBody = _listDataArr[indexPath.row];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"QuickCellPush" object:nil userInfo:@{@"cellUrl":listBody.num_iid}];
}
#pragma mark ------返回单元格--
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    QuickyBody *listBody = _listDataArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.ListImg setImageWithURL:[NSURL URLWithString:listBody.pic_url] placeholderImage:[UIImage imageNamed:@"img_ipad"]];
    cell.ListTitle.text = listBody.title;
    cell.now_price.text = [NSString stringWithFormat:@"￥%@",listBody.now_price];
    cell.origin_price.text = [NSString stringWithFormat:@"￥%@",listBody.origin_price];
    cell.discount.text = [NSString stringWithFormat:@"%@折",listBody.discount];
    
    return cell;
}

#pragma mark ------定义单元格大小--
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(150, 210);
    return size;
}
#pragma mark ------定义内置偏移量--
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(2.5, 5, 0, 5);
    return insets;
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
