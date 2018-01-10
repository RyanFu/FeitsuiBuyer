//
//  JNTextView.h
//  自定义TextView
//
//  Created by Yukino on 2017/10/24.
//  Copyright © 2017年 Yukino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
