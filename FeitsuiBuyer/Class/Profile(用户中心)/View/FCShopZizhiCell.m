//
//  FCShopZizhiCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCShopZizhiCell.h"

@interface FCShopZizhiCell()

@property (weak, nonatomic) IBOutlet UIImageView *zhizhaoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posIDCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *negIDCardImageView;
// 执照
@property (weak, nonatomic) IBOutlet UIButton *upzhizhaoButton;
// 身份证正面
@property (weak, nonatomic) IBOutlet UIButton *upposIDCardButton;
// 身份证反面
@property (weak, nonatomic) IBOutlet UIButton *upnegIDCardButton;


@end

@implementation FCShopZizhiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

// 执照
- (IBAction)upzhizhaoButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upzhizhao)]) {
        [self.delegate upzhizhao];
    }
}

// 身份证正面
- (IBAction)upposIDCardButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upposIDCard)]) {
        [self.delegate upposIDCard];
    }
}

// 身份证反面
- (IBAction)upnegIDCardButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(upnegIDCard)]) {
        [self.delegate upnegIDCard];
    }
}

@end
