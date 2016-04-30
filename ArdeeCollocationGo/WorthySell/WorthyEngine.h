//
//  WorthyEngine.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorthyEngine : NSObject
+ (void)getWorthyListImgWithTabid:(int)tabId withComplent:(void(^)(NSArray *))complentBlock;
@end
