//
//  HomeViewEngine.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/27.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "HomeViewEngine.h"
#import "ListBody.h"
#import "AFHTTPRequestOperationManager.h"
#import "CodeHeader.h"

@implementation HomeViewEngine
+ (void)getIndexBannerImgWithComplentBlock: (void(^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?&%@&%@&%@&%@&%@",BANNER_REQUEST,APP_ID,APP_OID,APP_Version,APP_Channel,SCHE];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *bannerArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"data"])
        {
            BannerBody *bannerBody = [[BannerBody alloc]init];
            [bannerBody setValuesForKeysWithDictionary:bodyDic];
            [bannerArr addObject:bannerBody];
        }
       
        complentBlock(bannerArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
+ (void)getHomeListWithCid:(int)cid withComplent:(void(^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?control=%@&model=%@&app_id=%@&app_oid=%@&app_version=%@&app_channel=%@&cid=%d",LIST_REQUEST,Control,MODEL,APP_ID,APP_OID,APP_Version,APP_Channel,cid];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *listArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"list"])
        {
            ListBody *listBody = [[ListBody alloc]init];
            [listBody setValuesForKeysWithDictionary:bodyDic];
            [listArr addObject:listBody];
        }
        complentBlock(listArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
+ (void)getTomorrowListWithComplent:(void (^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?app_id=%@&app_oid=%@&app_version=%@&app_channel=%@&sche=%@",TOMORROW_REQUEST,APP_ID,APP_OID,APP_Version,APP_Channel,SCHE];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"输出:%@",responseObject);
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *listArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"list"])
        {
            ListBody *listBody = [[ListBody alloc]init];
            [listBody setValuesForKeysWithDictionary:bodyDic];
            [listArr addObject:listBody];
        }
        complentBlock(listArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
@end
