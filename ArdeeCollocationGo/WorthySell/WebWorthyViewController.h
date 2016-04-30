//
//  WebWorthyViewController.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/1.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorthyBody.h"

@interface WebWorthyViewController : UIViewController
@property (nonatomic,strong)WorthyBody *worthyBody;
@property (nonatomic,copy)NSString *urlStr;
@end
