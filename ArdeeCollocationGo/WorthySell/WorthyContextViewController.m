//
//  WorthyContextViewController.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "WorthyContextViewController.h"
#import "WorthyTableViewCell.h"
#import "WorthyEngine.h"
#import "UIImageView+WebCache.h"
#import "WorthyBody.h"

@interface WorthyContextViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_listDataArr;
}
@end

@implementation WorthyContextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _listDataArr = [[NSArray alloc]init];
    [self getData];
    [self initTableView];
    
    
}
#pragma mark ------创建tableView--
- (void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 415)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"WorthyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"worthyCell"];
    [self.view addSubview:_tableView];
}
- (void)getData
{
    [WorthyEngine getWorthyListImgWithTabid:self.tab_id withComplent:^(NSArray *listArr)
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
    WorthyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"worthyCell" forIndexPath:indexPath];
    WorthyBody *worthyBody = _listDataArr[indexPath.row];
    [cell.cellImg setImageWithURL:[NSURL URLWithString:worthyBody.bannerUrl] placeholderImage:[UIImage imageNamed:@"img_ipad"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorthyBody *worthyBody = _listDataArr[indexPath.row];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"商品详情" object:nil userInfo:@{@"worthyBody":worthyBody}];
}
#pragma mark ------返回单元格高度--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 167;
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
