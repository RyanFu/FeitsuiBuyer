//
//  FCUploadProductCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/21.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCUploadProductCell.h"

@interface FCUploadProductCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *titleView;

@end

@implementation FCUploadProductCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)loadViewWithInfo:(NSString *)infoString {
    self.titleLabel.text = infoString;
}

- (UIView *)titleView {
    if (_titleView == nil) {
        _titleView = [[UIView alloc] initWithFrame:self.bounds];
        [_titleView addSubview:self.arrowImageView];
        self.contentView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
        [self.contentView addSubview:_titleView];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 8 , 0, self.bounds.size.width / 8 * 5, self.bounds.size.height)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:10.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView {
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"上箭头"]];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.frame = CGRectMake(self.bounds.size.width / 8 * 6, 0, self.bounds.size.width / 8, self.bounds.size.height);
    }
    return _arrowImageView;
}

@end
