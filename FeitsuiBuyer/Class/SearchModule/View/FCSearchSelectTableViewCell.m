//
//  FCSearchSelectTableViewCell.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSearchSelectTableViewCell.h"
#import "FCSearchSelectModel.h"
#import "UIColor+JYColor.h"

@interface FCSearchSelectTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *seperatorView;

@end

@implementation FCSearchSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self buildCellView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-2);
    self.seperatorView.frame = CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2);
}

- (void)reloadViewWithData:(FCSearchSelectModel *)model{
    self.titleLabel.text = model.cat_name;
}

- (void)setUpViewBackgroundColor:(UIColor *)color{
    self.titleLabel.backgroundColor = color;
}

- (void)buildCellView {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:13.f];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor colorWithHexString:@"#E1E2E3"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.seperatorView = [[UIView alloc]init];
    self.seperatorView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.seperatorView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
