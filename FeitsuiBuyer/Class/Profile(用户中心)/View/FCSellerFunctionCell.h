//
//  FCSellerFunctionCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FCSellerFunctionCellDelegate<NSObject>

@optional

// 管理商品
- (void)managerViewClick;
// 添加商品
- (void)addViewClick;
// 订单信息
- (void)orderViewClick;

@end

@interface FCSellerFunctionCell : UITableViewCell

@property (nonatomic, weak) id<FCSellerFunctionCellDelegate> delegate;

@end
