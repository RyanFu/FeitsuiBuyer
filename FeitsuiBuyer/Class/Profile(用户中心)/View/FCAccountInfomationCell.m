//
//  FCAccountInfomationCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCAccountInfomationCell.h"

@interface FCAccountInfomationCell()

// 银行持卡人姓名1
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
// 银行账号1
@property (weak, nonatomic) IBOutlet UILabel *accountNumberLabel;
// 开户行1
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
// 银行持卡人姓名2
@property (weak, nonatomic) IBOutlet UILabel *secondAccountNameLabel;
// 银行账号2
@property (weak, nonatomic) IBOutlet UILabel *secondAccountNumberLabel;
// 开户行2
@property (weak, nonatomic) IBOutlet UILabel *secondBankNameLabel;
// 支付宝姓名
@property (weak, nonatomic) IBOutlet UILabel *zfbNameLabel;
// 支付宝账号1
@property (weak, nonatomic) IBOutlet UILabel *zfbNumberLabel;
// 支付宝姓名2
@property (weak, nonatomic) IBOutlet UILabel *secondZfbNameLabel;
// 支付宝账号2
@property (weak, nonatomic) IBOutlet UILabel *secondZfbNumberLabel;


@end

@implementation FCAccountInfomationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
