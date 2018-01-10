//
//  FCSellerInfomationCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSellerInfomationCell.h"

@interface FCSellerInfomationCell()

// 姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 电话
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
// 商户地址
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
// 主营
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
// 商铺名称
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
// 微信号
@property (weak, nonatomic) IBOutlet UILabel *wxNumberLabel;



@end

@implementation FCSellerInfomationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
