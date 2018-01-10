//
//  FCShopZizhiCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/17.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCShopZizhiCellDelegate<NSObject>

@optional
// 上传执照
- (void)upzhizhao;
// 上传身份证正面
- (void)upposIDCard;
// 上传身份证反面
- (void)upnegIDCard;

@end

@interface FCShopZizhiCell : UITableViewCell

@property (nonatomic, weak) id<FCShopZizhiCellDelegate> delegate;

@end
