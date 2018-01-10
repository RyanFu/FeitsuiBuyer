//
//  FCMessageViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/2.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCMessageViewController.h"
#import "FCMessageCell.h"
#import "FCLoginViewController.h"
#import <Masonry.h>
#import <RTRootNavigationController.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FCMessageViewController ()


@end

@implementation FCMessageViewController
static NSString * const messageCellID = @"messageCellID";

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"is_login"]) {
//        [self setupTableView];
//    }
//    else {
//        [self setupVisitorView];
//    }
    
    [self setupNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitAccount) name:@"ExitAccountNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"LoginSuccessNotification" object:nil];
}

/**
 * 布局访客页面
 */
- (void)setupVisitorView {
    UIButton *loginButon = [[UIButton alloc] init];
    [loginButon setBackgroundColor:[UIColor whiteColor]];
    [loginButon setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginButon setTitleColor:[UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
    [loginButon.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [loginButon addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:loginButon];
    [loginButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}


/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"消息";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *listButton = [[UIButton alloc] init];
    listButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [listButton setTitle:@"列表" forState:UIControlStateNormal];
    [listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [listButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    [listButton.layer setBorderWidth:1];
    listButton.layer.cornerRadius = 2;
    listButton.layer.masksToBounds = YES;
    [listButton addTarget:self action:@selector(listButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
}


/**
 * 初始化tableView
 */
- (void)setupTableView {
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FCMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:messageCellID];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    UIButton *bottomButton = [[UIButton alloc] init];
    [bottomButton setBackgroundColor:[UIColor whiteColor]];
    [bottomButton setTitle:@"联系客服" forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomButton setTitleColor:[UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
    [bottomButton addTarget:self action:@selector(kefuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(30);
        make.left.right.mas_equalTo(view);
        make.height.mas_equalTo(40);
    }];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:messageCellID forIndexPath:indexPath];
    if (indexPath.row == 0) {
        messageCell.titleLabel.text = @"通知消息";
    }
    if (indexPath.row == 1) {
        messageCell.titleLabel.text = @"活动优惠";
    }
    return messageCell;
}

#pragma mark - 点击事件
// 访客视图---立即登录
- (void)loginButtonClick {
    FCLoginViewController *loginViewController = [[FCLoginViewController alloc] init];
    RTRootNavigationController *loginNagigationContrller = [[RTRootNavigationController alloc] initWithRootViewController:loginViewController];
    loginNagigationContrller.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginNagigationContrller animated:YES completion:nil];
}

// 退出登录
- (void)exitAccount {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self setupVisitorView];
    [self.view layoutIfNeeded];
}

// 登录成功
- (void)loginSuccess {
    for (UIView *view in self.tableView.subviews) {
        [view removeFromSuperview];
        
    }
    [self setupTableView];
    [self.tableView reloadData];
}

- (void)listButtonClick {
    NSLog(@"列表");
}

- (void)kefuButtonClick {
    NSLog(@"联系客服");
}

@end
