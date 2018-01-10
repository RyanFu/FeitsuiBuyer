//
//  FCHomeViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/12.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCHomeViewController.h"
#import "FCNewViewController.h"
#import "FCQingsheViewController.h"
#import "FCMingjiaViewController.h"
#import "FCNanhongViewController.h"
#import "FCHupoViewController.h"
#import "FCQitaViewController.h"
#import "FCCategoriesListViewController.h"
#import <Masonry.h>
#import "FCSearchViewController.h"
#import "FCUploadProductViewController.h"
#import "FCProductDetailViewController.h"
#import "FCNetworkingManager.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface FCHomeViewController () <UIScrollViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) FCNewViewController *newVC;
@property (nonatomic, strong) FCQingsheViewController *qingsheVC;
@property (nonatomic, strong) FCMingjiaViewController *mingjiaVC;
@property (nonatomic, strong) FCNanhongViewController *nanhongVC;
@property (nonatomic, strong) FCHupoViewController *hupoVC;
@property (nonatomic, strong) FCQitaViewController *qitaVC;


@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *previousButton;

@property (nonatomic, strong) UIView *titleUnderline;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *titleArray;
// 搜索框
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *searchView;


@end

@implementation FCHomeViewController

#pragma mark - setter/getter
- (NSArray *)titleArray {
    if (_titleArray == nil) {
        NSArray *array = @[@"最新",@"轻奢小品",@"名家收藏",@"南红",@"琥珀蜜蜡",@"其他"];
        _titleArray = [NSArray arrayWithArray:array];
    }
    return _titleArray;
}
- (FCNewViewController *)newVC {
    if (_newVC == nil) {
        _newVC = [[FCNewViewController alloc] init];
    }
    return _newVC;
}

- (FCQingsheViewController *)qingsheVC {
    if (_qingsheVC == nil) {
        _qingsheVC = [[FCQingsheViewController alloc] init];
    }
    return _qingsheVC;
}

- (FCMingjiaViewController *)mingjiaVC {
    if (_mingjiaVC == nil) {
        _mingjiaVC = [[FCMingjiaViewController alloc] init];
    }
    return _mingjiaVC;
}

- (FCNanhongViewController *)nanhongVC {
    if (_nanhongVC == nil) {
        _nanhongVC = [[FCNanhongViewController alloc] init];
    }
    return _nanhongVC;
}

- (FCHupoViewController *)hupoVC {
    if (_hupoVC == nil) {
        _hupoVC = [[FCHupoViewController alloc] init];
    }
    return _hupoVC;
}

- (FCQitaViewController *)qitaVC {
    if (_qitaVC == nil) {
        _qitaVC = [[FCQitaViewController alloc] init];
    }
    return _qitaVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    [self setupNavigationBar];
    [self setupAllViews];
}

/**
 * 点击空白收起键盘
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    // 计算搜索框范围 范围内不执行方法 之外执行键盘回收
    CGPoint touchPoint = [touch locationInView:self.view];
    if (touchPoint.x > _searchView.bounds.origin.x && touchPoint.x < _searchView.bounds.origin.x + _searchView.bounds.size.width && touchPoint.y > _searchView.bounds.origin.y && touchPoint.y < _searchView.bounds.origin.y + _searchView.bounds.size.height) {
        
    } else {
        [_searchBar resignFirstResponder];
    }
}

/**
 * 初始化 Navigation
 */
- (void)setupNavigationBar {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.masksToBounds = YES;
    searchView.backgroundColor = [UIColor whiteColor];
    _searchView = searchView;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    searchBar.delegate = self;
    [searchBar setTintColor:[UIColor whiteColor]];
    [searchView addSubview:searchBar];
    _searchBar = searchBar;
    
    self.navigationItem.titleView = searchView;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:1/255.0 alpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"列表"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"列表"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
}

- (void)leftBarButtonClick {
    FCUploadProductViewController *vc = [[FCUploadProductViewController alloc] init];
//    FCProductDetailViewController *vc = [[FCProductDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarButtonClick {
    // 先收键盘再push
    [_searchBar resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        FCSearchViewController *vc = [[FCSearchViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    });
    
}


/**
 * 初始化所有View
 */
- (void)setupAllViews {
    [self setupAllViewController];
    [self setupScrollView];
    [self setupTitleView];
    [self setupTitleButton];
    [self setupUnderLine];
    [self addChildVCToScrollView:0];
}

/**
 * 初始化控制器
 */
- (void)setupAllViewController {
    
    [self addChildViewController:self.newVC];
    
    [self addChildViewController:self.qingsheVC];
    
    [self addChildViewController:self.mingjiaVC];
    
    [self addChildViewController:self.nanhongVC];
    
    [self addChildViewController:self.hupoVC];
    
    [self addChildViewController:self.qitaVC];
}

/**
 * 设置title的Content View
 */
- (void)setupTitleView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    titleView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1/255.0 alpha:1];
    _titleView = titleView;
    [self.view addSubview:titleView];
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
        [button setTitleColor:[UIColor colorWithRed:246/255.0 green:241/255.0 blue:195/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
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
        [self addChildVCToScrollView:i];
    }];
    
    CGRect rect = self.titleUnderline.frame;
    rect.origin.x = button.frame.origin.x;
    rect.size.width = button.frame.size.width;
    self.titleUnderline.frame = rect;
}


/**
 * 设置下划线
 */
- (void)setupUnderLine {
    UIButton *button = self.titleView.subviews.firstObject;
    UIView *titleUnderline = [[UIView alloc] init];
    CGFloat lineH = 1;
    CGFloat lineY = self.titleView.frame.size.height - lineH * 2;
    CGFloat lineW = button.frame.size.width;
    
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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
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
    NSInteger i = scrollView.contentOffset.x / kScreenWidth;
    
    UIButton *titleButton = self.titleView.subviews[i];
    
    [self titleButtonClicked:titleButton];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    FCSearchViewController *vc = [[FCSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 其他
- (void)addChildVCToScrollView:(NSInteger)index {
    CGFloat scrollViewW = self.contentScrollView.frame.size.width;
    CGFloat scrollViewH = self.contentScrollView.frame.size.height;
    UIView *childView = self.childViewControllers[index].view;
    childView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, scrollViewH);
    [self.contentScrollView addSubview:childView];
}

@end
