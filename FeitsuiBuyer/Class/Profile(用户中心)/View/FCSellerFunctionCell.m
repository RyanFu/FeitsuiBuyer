//
//  FCSellerFunctionCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSellerFunctionCell.h"

@interface FCSellerFunctionCell()

@property (weak, nonatomic) IBOutlet UIView *managerView;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property (weak, nonatomic) IBOutlet UIView *orderView;

@end

@implementation FCSellerFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addGesture];
}

- (void)addGesture {
    UITapGestureRecognizer *managerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(managerViewClick)];
    [_managerView addGestureRecognizer:managerTap];
    
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewClick)];
    [_addView addGestureRecognizer:addTap];
    
    UITapGestureRecognizer *orderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderViewClick)];
    [_orderView addGestureRecognizer:orderTap];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 管理商品
- (void)managerViewClick {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SellerManagerViewClickNotification" object:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(managerViewClick)]) {
        [self.delegate managerViewClick];
    }
}

// 添加商品
- (void)addViewClick {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SellerAddViewClickNotification" object:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addViewClick)]) {
        [self.delegate addViewClick];
    }
}

// 订单信息
- (void)orderViewClick {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SellerOrderViewClickNotification" object:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(orderViewClick)]) {
        [self.delegate orderViewClick];
    }
}

@end
