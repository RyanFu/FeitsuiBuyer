//
//  FCCouPonsViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/29.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCCouPonsViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FCCouPonsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *previousButton;

@property (nonatomic, strong) UIView *titleUnderline;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation FCCouPonsViewController

- (NSArray *)titleArray {
    if (_titleArray == nil) {
        NSArray *array = @[@"未使用(0)",@"已使用(0)",@"已过期(0)"];
        _titleArray = [NSArray arrayWithArray:array];
    }
    return _titleArray;
}

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self setupNavigationBar];
    [self setupAllViews];
}

- (void)setupAllViews {
    [self setupScrollView];
    [self setupTitleView];
    [self setupTitleButton];
    [self setupUnderLine];
}

/**
 * 设置标题按钮
 */
- (void)setupTitleButton {
    NSInteger count = _titleArray.count;
    CGFloat buttonW = self.titleView.frame.size.width / count;
    CGFloat buttonH = self.titleView.frame.size.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonW * i, 0, buttonW, buttonH)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.titleView addSubview:button];
    }
    
}


/**
 * 标题按钮点击事件
 */
- (void)titleButtonClicked:(UIButton *)button {
    self.previousButton.selected = NO;
    button.selected = YES;
    self.previousButton = button;
    NSInteger i = button.tag;
    self.titleUnderline.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.titleUnderline.alpha = 1;
        
        CGFloat offsetX = self.contentScrollView.frame.size.width * i;
        self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    } completion:^(BOOL finished) {
        
    }];
    
    CGRect rect = self.titleUnderline.frame;
    rect.origin.x = button.frame.origin.x;
    rect.size.width = button.frame.size.width;
    self.titleUnderline.frame = rect;
}


/**
 * 设置title的Content View
 */
- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 35)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    _titleView = titleView;
    [self.view addSubview:titleView];
}


/**
 * 设置下划线
 */
- (void)setupUnderLine {
    UIButton *button = self.titleView.subviews.firstObject;
    UIView *titleUnderline = [[UIView alloc] init];
    CGFloat lineH = 1;
    CGFloat lineY = self.titleView.frame.size.height - lineH;
    CGFloat lineW = 100;
    titleUnderline.frame = CGRectMake(0, lineY, lineW, lineH);
    titleUnderline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    //初始选择按钮
    button.selected = YES;
    self.previousButton = button;
    //初始的下划线
    CGRect rect = self.titleUnderline.frame;
    rect.size.width = button.frame.size.width;
    self.titleUnderline.frame = rect;
}


/**
 * 滑动选择title
 */
- (void)setupScrollView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    NSInteger count = self.titleArray.count;
    CGFloat scrollW = scrollView.frame.size.width;
    scrollView.contentSize = CGSizeMake(count * scrollW, 0);
    [self.view addSubview:scrollView];
    self.contentScrollView = scrollView;
}

#pragma mark - UIScollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = scrollView.contentOffset.x / SCREEN_WIDTH;
    
    UIButton *titleButton = self.titleView.subviews[i];
    
    [self titleButtonClicked:titleButton];
}

/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"红包卡券";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
