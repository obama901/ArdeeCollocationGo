//
//  TomorrowViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/3.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "TomorrowViewController.h"
#import "HomeViewEngine.h"
#import "HomeCollectionViewCell.h"
#import "ListBody.h"
#import "UIImageView+WebCache.h"

@interface TomorrowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSArray *_listDataArr;
}

@end

@implementation TomorrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listDataArr = [[NSArray alloc]init];
    [self getData];
    [self initCollectionView];
}
#pragma mark ------创建collectionView--
- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1];
    _collectionView.dataSource =self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell1"];
    [self.view addSubview:_collectionView];
    
}
#pragma mark ------接收数据--
- (void)getData
{
    
    [HomeViewEngine getTomorrowListWithComplent:^(NSArray *listArr) {
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
