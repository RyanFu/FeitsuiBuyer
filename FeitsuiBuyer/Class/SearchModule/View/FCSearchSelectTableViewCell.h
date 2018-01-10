//
//  FCSearchSelectTableViewCell.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCSearchSelectModel;

@interface FCSearchSelectTableViewCell : UITableViewCell

- (void)reloadViewWithData:(FCSearchSelectModel *)model;

- (void)setUpViewBackgroundColor:(UIColor *)color;

@end
