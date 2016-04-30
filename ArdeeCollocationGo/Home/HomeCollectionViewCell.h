//
//  HomeCollectionViewCell.h
//  ArdeeCollocationGo
//
//  Created by Ardee on 16/2/29.
//  Copyright © 2016年 Ardee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ListImg;
@property (weak, nonatomic) IBOutlet UILabel *ListTitle;
@property (weak, nonatomic) IBOutlet UILabel *now_price;
@property (weak, nonatomic) IBOutlet UILabel *origin_price;
@property (weak, nonatomic) IBOutlet UILabel *discount;

@end
