//
//  JNBannerFooter.h
//  JNBannerView
//
//  Created by Yukino on 2017/12/12.
//  Copyright © 2017年 Yukino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNBannerFooter : UICollectionReusableView

typedef NS_ENUM(NSUInteger, JNBannerFooterState) {
    JNBannerFooterStateNormal = 0,    // 正常状态下的footer提示
    JNBannerFooterStateTrigger,     // 被拖至触发点的footer提示
};

@property (nonatomic, assign) JNBannerFooterState state;

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *idleTitle;
@property (nonatomic, copy) NSString *triggerTitle;

@end
