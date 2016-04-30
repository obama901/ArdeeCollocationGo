//
//  QuickyEngine.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "QuickyEngine.h"
#import "CodeHeader.h"
#import "AFHTTPRequestOperationManager.h"
#import "QuickyBody.h"

@implementation QuickyEngine
+ (void)getQuickyListWithCid:(int)cid withComplent:(void(^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?cid=%d&app_id=%@&app_oid=%@&app_version=%@&app_channel=%@&sche=%@",QUICKY_REQUEST,cid,APP_ID,APP_OID,APP_Version,APP_Channel,SCHE];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *listArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"list"])
        {
            QuickyBody *listBody = [[QuickyBody alloc]init];
            [listBody setValuesForKeysWithDictionary:bodyDic];
            [listArr addObject:listBody];
        }
        complentBlock(listArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
@end
