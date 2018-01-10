//
//  FCEssayCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/30.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCEssayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *browseNumLabel;

@end
