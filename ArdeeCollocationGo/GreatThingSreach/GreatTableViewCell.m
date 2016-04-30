//
//  GreatTableViewCell.m
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/3/2.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import "GreatTableViewCell.h"

@implementation GreatTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.listImg.layer.cornerRadius = 10;
    self.listImg.clipsToBounds = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
