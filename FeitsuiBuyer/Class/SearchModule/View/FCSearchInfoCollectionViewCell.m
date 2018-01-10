//
//  FCSearchInfoCollectionViewCell.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSearchInfoCollectionViewCell.h"
#import "FCSearchInfoModel.h"
#import "UIColor+JYColor.h"

@interface FCSearchInfoCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FCSearchInfoCollectionViewCell

- (void)loadViewWithInfo:(NSString *)infoString{
    self.titleLabel.text = infoString;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#E7E8E9"];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
