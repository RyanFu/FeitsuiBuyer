//
//  FCProfileFunctionCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/26.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCProfileFunctionCellDelegate<NSObject>

@optional

// 红包卡券
- (void)couponsViewClick;
// 浏览历史
- (void)browseHistoryViewClick;
// 我的收藏
- (void)collectionViewClick;

@end

@interface FCProfileFunctionCell : UITableViewCell

@property (nonatomic, weak) id<FCProfileFunctionCellDelegate> delegate;

@end
