//
//  PersonTableViewCell.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/2.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *perImg;
@property (weak, nonatomic) IBOutlet UILabel *perTitle;
@property (weak, nonatomic) IBOutlet UILabel *perStatus;

@end
