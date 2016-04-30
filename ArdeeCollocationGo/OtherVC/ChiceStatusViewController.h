//
//  ChiceStatusViewController.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/4.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChiceStatusViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (nonatomic,strong)UILabel *label5;
@property (nonatomic,strong)NSString *statusCode;
@end
