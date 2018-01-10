//
//  JNBannerView.h
//  JNBannerView
//
//  Created by Yukino on 2017/12/12.
//  Copyright © 2017年 Yukino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNBannerFooter.h"

@protocol JNBannerViewDataSource, JNBannerViewDelegate;

@interface JNBannerView : UIView

/** 是否需要循环滚动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL shouldLoop;

/** 是否显示 footer, 默认为 NO (此属性为 YES 时, shouldLoop 会被置为 NO) */
@property (nonatomic, assign) IBInspectable BOOL showFooter;

/** 是否自动滑动, 默认为 NO */
@property (nonatomic, assign) IBInspectable BOOL autoScroll;

/** 自动滑动间隔时间(s), 默认为 3.0 */
@property (nonatomic, assign) IBInspectable CGFloat scrollInterval;

/** pageControl, 可自由配置其属性 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, assign, readwrite)  CGRect pageControlFrame;

/** 当前 item 的 index */
@property (nonatomic, assign) NSInteger currentIndex;
- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated;

@property (nonatomic, weak) id<JNBannerViewDataSource> dataSource;
@property (nonatomic, weak) id<JNBannerViewDelegate> delegate;

- (void)reloadData;

- (void)startTimer;
- (void)stopTimer;

@end

@protocol JNBannerViewDataSource <NSObject>
@required

/**
 * 返回Banner需要显示item(View)的个数
 */
- (NSInteger)numberOfItemsInBanner:(JNBannerView *)banner;

/**
 * 返回Banner在不同的index所要显示的View
 */
- (UIView *)banner:(JNBannerView *)banner viewForItemAtIndex:(NSInteger)index;

@optional


/**
 * 返回Footer显示的文字
 */
- (NSString *)banner:(JNBannerView *)banner titleForFooterWithState:(JNBannerFooterState)footerState;

@end

@protocol JNBannerViewDelegate <NSObject>
@optional

/**
 * 当点击了第index个tem时, 调用此方法
 */
- (void)banner:(JNBannerView *)banner didSelectItemAtIndex:(NSInteger)index;

/**
 * 当滑动到第index个tem时, 调用此方法
 */
- (void)banner:(JNBannerView *)banner didScrollToItemAtIndex:(NSInteger)index;

/**
 * 拖动Footer后的动作
 */
- (void)bannerFooterDidTrigger:(JNBannerView *)banner;

@end
