//
//  WorthyEngine.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "WorthyEngine.h"
#import "CodeHeader.h"
#import "AFHTTPRequestOperationManager.h"
#import "WorthyBody.h"

@implementation WorthyEngine
+ (void)getWorthyListImgWithTabid:(int)tabId withComplent:(void(^)(NSArray *))complentBlock
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?control=%@&model=%@&tabId=%d&page=%d&access_token=(null)&appkey=%@&app_oid=%@&app_id=%@&app_version=%@&app_channel=%@&shce=%@&pay=%@&",WORTHY_REQUEST,TAB3_Control,TAB3_MODEL,tabId,1,APPKEY,APP_OID,APP_ID,APP_Version,APP_Channel,SCHE,PAY];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        NSDictionary *jsonDic = (NSDictionary *)responseObject;
        NSMutableArray *ListArr = [[NSMutableArray alloc]init];
        for (NSDictionary *bodyDic in jsonDic[@"data"])
        {
            WorthyBody *worthyBody = [[WorthyBody alloc]init];
            [worthyBody setValuesForKeysWithDictionary:bodyDic];
            [ListArr addObject:worthyBody];
        }
        complentBlock(ListArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误的原因是:%@",error);
    }];
}
@end
