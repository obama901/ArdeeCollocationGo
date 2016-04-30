//
//  GreatEngine.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/2.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "GreatEngine.h"
#import "AFHTTPRequestOperationManager.h"
#import "CodeHeader.h"
#import "GreatBody.h"

@implementation GreatEngine
+ (void)getGreatListViewWithComplent:(void(^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?page=1&limit=1000&appkey=%@&app_oid==%@&app_id==%@&app_version=%@&app_channel=%@&shce",GREAT_REQUEST,APPKEY,APP_OID,APP_ID,APP_Version,APP_Channel];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *listArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"list"])
        {
            GreatBody *greatBody = [[GreatBody alloc]init];
            [greatBody setValuesForKeysWithDictionary:bodyDic];
            [listArr addObject:greatBody];
        }
        complentBlock(listArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
@end
