//
//  QuickyEngine.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickyEngine : NSObject
+ (void)getQuickyListWithCid:(int)cid withComplent:(void(^)(NSArray *))complentBlock;
@end
