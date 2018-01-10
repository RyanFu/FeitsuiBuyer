//
//  FCMessageCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/2.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCMessageCell.h"

@implementation FCMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 30.f;
    self.iconImageView.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
