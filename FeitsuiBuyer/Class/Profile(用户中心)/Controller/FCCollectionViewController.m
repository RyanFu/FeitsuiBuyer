//
//  FCCollectionViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/30.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCCollectionViewController.h"
#import "FCCommodityCell.h"
#import "FCEssayCell.h"
#import <Masonry.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FCCollectionViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *previousButton;

@property (nonatomic, strong) UIView *titleUnderline;

@property (nonatomic, strong) UIScrollView *contentScrollView;
//宝贝
@property (nonatomic, strong) UITableView *commodityTableView;
//文章
@property (nonatomic, strong) UITableView *essayTableView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation FCCollectionViewController
static NSString * const commodityCellID = @"commodityCellID";
static NSString * const essayCellID = @"essayCellID";

- (NSArray *)titleArray {
    if (_titleArray == nil) {
        NSArray *array = @[@"宝贝",@"内容"];
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
    [self setupTableView];
    [self setupBottomView];
}

/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的收藏";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空|编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAllCommodities)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
 * 初始化所有控制器
 */
- (void)setupAllViewControllers {
    
}

- (void)addChildVCToScrollView:(NSInteger)index {
    
}


/**
 * 设置底部全选删除按钮
 */
- (void)setupBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(60);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(60);
    }];
    _bottomView = bottomView;
    UIButton *selectAllButton = [[UIButton alloc] init];
    [selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAllButton setBackgroundColor:[UIColor whiteColor]];
    [selectAllButton addTarget:self action:@selector(selectAllButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:selectAllButton];
    [selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.bottom.mas_equalTo(bottomView.mas_bottom);
        make.left.mas_equalTo(bottomView.mas_left);
        make.width.mas_equalTo(bottomView.mas_width).multipliedBy(0.5);
    }];
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteButton setBackgroundColor:[UIColor redColor]];
    [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:deleteButton];
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_top);
        make.bottom.mas_equalTo(bottomView.mas_bottom);
        make.right.mas_equalTo(bottomView.mas_right);
        make.width.mas_equalTo(bottomView.mas_width).multipliedBy(0.5);
    }];
}

/**
 * 编辑浏览历史列表
 */
- (void)editAllCommodities {
    CGFloat scrollW = self.contentScrollView.frame.size.width;
    for (UIButton *button in self.titleView.subviews) {
        button.enabled = !button.enabled;
    }
    if (self.contentScrollView.contentOffset.x < scrollW) {
        [self.commodityTableView setEditing:!self.commodityTableView.editing animated:YES];
    }
    else {
        [self.essayTableView setEditing:!self.essayTableView.editing animated:YES];
    }
    
    if (self.commodityTableView.editing == YES || self.essayTableView.editing == YES) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
    }
    else {
        self.navigationItem.rightBarButtonItem.title = @"清空|编辑";
        [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(60);
        }];
    }
    
}

- (void)selectAllButtonClick {
    NSLog(@"全选");
}

- (void)deleteButtonClick {
    NSLog(@"删除");
}

#pragma mark - TableView

/**
 * 初始化tableView
 */
- (void)setupTableView {
    CGFloat scrollViewW = self.contentScrollView.frame.size.width;
    CGFloat scrollViewH = self.contentScrollView.frame.size.height;
    //商品列表TableView
    UITableView *commodityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, scrollViewW, scrollViewH) style:UITableViewStylePlain];
    commodityTableView.delegate = self;
    commodityTableView.dataSource = self;
    commodityTableView.separatorInset = UIEdgeInsetsZero;
    commodityTableView.separatorColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    commodityTableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    commodityTableView.estimatedRowHeight = 100;
    commodityTableView.rowHeight = UITableViewAutomaticDimension;
    
    [commodityTableView registerNib:[UINib nibWithNibName:@"FCCommodityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:commodityCellID];
    [self.contentScrollView addSubview:commodityTableView];
    _commodityTableView = commodityTableView;
    
    //文章TableView
    UITableView *essayTableView = [[UITableView alloc] initWithFrame:CGRectMake(scrollViewW, 0, scrollViewW, scrollViewH) style:UITableViewStylePlain];
    essayTableView.delegate = self;
    essayTableView.dataSource = self;
    essayTableView.separatorInset = UIEdgeInsetsZero;
    essayTableView.separatorColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    essayTableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    essayTableView.estimatedRowHeight = 100;
    essayTableView.rowHeight = UITableViewAutomaticDimension;
    
    [essayTableView registerNib:[UINib nibWithNibName:@"FCEssayCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:essayCellID];
    [self.contentScrollView addSubview:essayTableView];
    _essayTableView = essayTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_commodityTableView]) {
        FCCommodityCell *commdityCell = [tableView dequeueReusableCellWithIdentifier:commodityCellID forIndexPath:indexPath];
        commdityCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return commdityCell;
    }
    else {
        FCEssayCell *essayCell = [tableView dequeueReusableCellWithIdentifier:essayCellID forIndexPath:indexPath];
        return essayCell;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

@end
