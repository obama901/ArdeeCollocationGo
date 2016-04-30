//
//  HomeIndexViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/27.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "HomeIndexViewController.h"
#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeViewEngine.h"
#import "BannerBody.h"
#import "DCPicScrollView.h"
#import "DCWebImageManager.h"
#import "ListBody.h"
#import "UIImageView+WebCache.h"
#import "TOWebViewController.h"
#import "SDRefresh.h"

@interface HomeIndexViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,SDRefreshViewAnimationDelegate>
{
    NSMutableArray *_imgUrlArr;
    NSMutableArray *_imgTitArr;
    NSMutableArray *_imgLinkArr;
    NSArray *_listDataArr;
    UICollectionView *_collectionView;
    NSMutableArray *_jkjListArr;
}
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@end

@implementation HomeIndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imgUrlArr = [[NSMutableArray alloc]init];
    _imgTitArr = [[NSMutableArray alloc]init];
    _imgLinkArr = [[NSMutableArray alloc]init];
    _listDataArr = [[NSArray alloc]init];
    _jkjListArr = [[NSMutableArray alloc]init];
    [self getData];
    [self initCollectionView];
    [self initFourBtn];
    [self setupHeader];
    [HomeViewEngine getIndexBannerImgWithComplentBlock:^(NSArray *bannerArr)
    {
        for (int a = 0; a<bannerArr.count; a ++)
        {
            BannerBody *bannerBody = bannerArr[a];
            [_imgUrlArr addObject:bannerBody.iphoneimg];
            [_imgTitArr addObject:bannerBody.title];
            [_imgLinkArr addObject:bannerBody.link];
        }
        DCPicScrollView  *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120) WithImageUrls:_imgUrlArr];
        picView.titleData = _imgTitArr;
        picView.placeImage = [UIImage imageNamed:@"umeng_logo.png"];
        //图片被点击事件,当前第几张图片被点击了,和数组顺序一致
        
        [picView setImageViewDidTapAtIndex:^(NSInteger index)
        {
            printf("第%zd张图片\n",index);
            

            TOWebViewController *webViewVC = [[TOWebViewController alloc]initWithURLString:_imgLinkArr[index]];
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
           
            [center postNotificationName:@"banner跳转" object:nil
                                userInfo:@{@"webView":webViewVC}];
        }];
        //default is 2.0f,如果小于0.5不自动播放
        picView.AutoScrollDelay = 3.0f;
        [_collectionView addSubview:picView];
        //下载失败重复下载次数,默认不重复,
        [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
        //下载失败调用的block
        [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url)
        {
            NSLog(@"banner图片下载失败的原因:%@",error);
        }];
    }];
    
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
#pragma mark ------接收数据--
- (void)getData
{
    [HomeViewEngine getHomeListWithCid:0 withComplent:^(NSArray *listArr)
    {
        _listDataArr = listArr;
        [_collectionView reloadData];
        for (int a = 0; a < listArr.count; a++)
        {
            ListBody *listBody = listArr[a];
            if ([listBody.now_price integerValue]<=9.9)
            {
                [_jkjListArr addObject:listBody];
            }
        }
    }];
}
#pragma mark ------创建collectionView--
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 415) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    layout.headerReferenceSize = CGSizeMake(320, 180);
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell1"];
    [self.view addSubview:_collectionView];
    
}
#pragma mark ------创建四个标题按钮--
- (void)initFourBtn
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, 320, 60)];
    bgView.backgroundColor = [UIColor whiteColor];
    [_collectionView addSubview:bgView];
    for (int a = 0; a < 4; a ++)
    {
        UIButton *fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        fourBtn.frame = CGRectMake(30+a*64, 0, 64, 52);
        fourBtn.tag = a + 1;
        [bgView addSubview:fourBtn];
        NSString *btnImg = [NSString stringWithFormat:@"btn_home%d",a];
        [fourBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fourBtn setImage:[UIImage imageNamed:btnImg] forState:UIControlStateNormal];
    }
    NSArray *strArr = @[@"九块九",@"手机充值",@"每日推荐",@"明日预告"];
    for (int a = 0; a < 4; a ++)
    {
        UILabel *fourLabel = [[UILabel alloc]initWithFrame:CGRectMake(23+a*64, 45, 80, 12)];
        fourLabel.text = strArr[a];
        fourLabel.font = [UIFont systemFontOfSize:10];
        fourLabel.textColor = [UIColor darkGrayColor];
        fourLabel.textAlignment = NSTextAlignmentCenter;
        [bgView addSubview:fourLabel];
    }
}
#pragma mark ------四个按钮的点击方法--
- (void)fourBtnClick:(UIButton *)btn
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if (btn.tag==1)
    {
        [center postNotificationName:@"九块九" object:nil userInfo:@{@"jkjListArr":_jkjListArr}];
    }else if (btn.tag==4)
    {
        [center postNotificationName:@"明日预告" object:nil];
    }else if (btn.tag==3)
    {
        [center postNotificationName:@"每日推荐" object:nil];
    }else if (btn.tag==2)
    {
        [center postNotificationName:@"手机充值" object:nil];
    }
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
    ListBody *listBody = _listDataArr[indexPath.row];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"HomeCellPush" object:nil userInfo:@{@"cellUrl":listBody.num_iid}];
}
#pragma mark ------返回单元格--
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    ListBody *listBody = _listDataArr[indexPath.row];
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
