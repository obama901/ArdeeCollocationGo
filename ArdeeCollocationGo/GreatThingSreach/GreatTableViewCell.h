//
//  GreatTableViewCell.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/2.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImg;
@property (weak, nonatomic) IBOutlet UILabel *listTitle;
@property (weak, nonatomic) IBOutlet UILabel *now_Pic;
@property (weak, nonatomic) IBOutlet UILabel *origin_pic;
@property (weak, nonatomic) IBOutlet UILabel *discount;

@end
