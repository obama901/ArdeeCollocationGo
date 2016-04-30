//
//  HomeViewEngine.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/27.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannerBody.h"

@interface HomeViewEngine : NSObject
+ (void)getIndexBannerImgWithComplentBlock: (void(^)(NSArray *))complentBlock;
+ (void)getHomeListWithCid:(int)cid withComplent:(void(^)(NSArray *))complentBlock;
+ (void)getTomorrowListWithComplent:(void(^)(NSArray *))complentBlock;
@end
