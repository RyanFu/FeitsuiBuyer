//
//  FCProfileFunctionCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCProfileFunctionCell.h"

@interface FCProfileFunctionCell()

@property (weak, nonatomic) IBOutlet UIView *couponsView;
@property (weak, nonatomic) IBOutlet UIView *browseHistoryView;
@property (weak, nonatomic) IBOutlet UIView *collectionView;

@end

@implementation FCProfileFunctionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addViewGesture];
}

- (void)addViewGesture {
    UITapGestureRecognizer *couponsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponsViewClick)];
    [_couponsView addGestureRecognizer:couponsTap];
    
    UITapGestureRecognizer *browseHistoryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browseHistoryViewClick)];
    [_browseHistoryView addGestureRecognizer:browseHistoryTap];
    
    UITapGestureRecognizer *collectionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewClick)];
    [_collectionView addGestureRecognizer:collectionTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 红包卡券
- (void)couponsViewClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(couponsViewClick)]) {
        [self.delegate couponsViewClick];
    }
}

// 浏览历史
- (void)browseHistoryViewClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(browseHistoryViewClick)]) {
        [self.delegate browseHistoryViewClick];
    }
}

// 我的收藏
- (void)collectionViewClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionViewClick)]) {
        [self.delegate collectionViewClick];
    }
}

@end
