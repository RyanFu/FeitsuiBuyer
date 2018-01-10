//
//  FCProfileViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCProfileViewController.h"
#import "UIImage+Extension.h"
#import "FCProfileOrderCell.h"
#import "FCProfileFunctionCell.h"
#import "FCSettingViewController.h"
#import "FCCouPonsViewController.h"
#import "FCBrowseHistoryViewController.h"
#import "FCCollectionViewController.h"
#import "FCUploadProductViewController.h"
#import "FCProductDetailViewController.h"
#import "FCNetworkingManager.h"
#import "FCLoginViewController.h"
#import "FCLoginModel.h"
#import "FCUserModel.h"
#import "FCUserDataModel.h"
#import "FCTokenManager.h"
#import <Masonry.h>
#import <RTRootNavigationController.h>
#import <CYLTabBarController.h>
#import <YYCache.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static const NSInteger kProfileViewHeight = 100;
static const NSInteger kIconHeight = 70;
static const NSInteger kTabBarHeight = 64;

static const NSInteger kOriOfftY = -100;
static const NSInteger kOriHeight = 100;





@interface FCProfileViewController ()<UITableViewDelegate, UITableViewDataSource, CYLTabBarControllerDelegate, FCProfileFunctionCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIView *profileContentView;

//@property (nonatomic, weak)UIView *barView;

// 头像
@property (nonatomic, strong)UIImageView *profileIconImageView;

// 背景
@property (nonatomic, strong)UIImageView *profileBackgroundImageView;

// 用户名
@property (nonatomic, strong)UILabel *profileUsernameLabel;

// 积分
@property (nonatomic, strong)UILabel *proPointsLabel;

// 等级
@property (nonatomic, strong)UILabel *proLevelLabel;

@property (nonatomic, strong)NSArray *cellDataArray;

@end

@implementation FCProfileViewController

static NSString * const profileOrderCellID = @"profileOrderCellID";

static NSString * const profileFunctionCellID = @"profileFunctionCellID";

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUserData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 是否登录
    if ([defaults boolForKey:@"is_login"]) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self setupAllViews];
        
        [self registTableViewCell];
        
        [self setupNotifications];
        //不自动调整scrollview内边距
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    else {
        
        self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
        [self setupVisitorView];
    }
    
    [self setupNavigationBar];
}

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/**
 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UIColor *alphColor = [UIColor colorWithWhite:1 alpha:0];
    UIImage *alphImage = [UIImage imageWithColor:alphColor];
    [self.navigationController.navigationBar setBackgroundImage:alphImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIButton *settingButton = [[UIButton alloc] init];
    [settingButton setImage:[UIImage imageNamed:@"设置.png"] forState:UIControlStateNormal];
    [settingButton setBackgroundColor:[UIColor colorWithRed:238/255.0 green:242/255.0 blue:243/255.0 alpha:1]];
    [settingButton.layer setCornerRadius:16];
    [settingButton.layer setMasksToBounds:YES];
    [settingButton sizeToFit];
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
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
    [self.view addSubview:loginButon];
    [loginButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}

/**
 * 布局主页面
 */
- (void)setupAllViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.layoutMargins = UIEdgeInsetsZero;
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(kProfileViewHeight + kTabBarHeight, 0, 0, 0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:contentView];
    _profileContentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(228);
    }];
    
    // 背景
    UIImageView *proBackgroundfileImageView = [[UIImageView alloc] init];
    proBackgroundfileImageView.image = [UIImage imageNamed:@"底图.jpg"];
    [contentView addSubview:proBackgroundfileImageView];
    _profileBackgroundImageView = proBackgroundfileImageView;
    [proBackgroundfileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top);
        make.bottom.mas_equalTo(contentView.mas_bottom);
        make.left.mas_equalTo(contentView.mas_left);
        make.right.mas_equalTo(contentView.mas_right);
    }];
    
    // 头像
    UIImageView *profileIconImageView = [[UIImageView alloc] init];
    profileIconImageView.backgroundColor = [UIColor whiteColor];
    profileIconImageView.layer.cornerRadius = kIconHeight / 2;
    profileIconImageView.layer.masksToBounds = YES;
    [contentView addSubview:profileIconImageView];
    _profileIconImageView = profileIconImageView;
    [profileIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat HMargin = (SCREEN_WIDTH - kIconHeight) / 2;
        CGFloat VMargin = (kProfileViewHeight - kIconHeight) / 2;
        make.width.mas_equalTo(kIconHeight);
        make.height.mas_equalTo(kIconHeight);
        make.bottom.mas_equalTo(contentView.mas_bottom).offset(-(VMargin + 78.5));
        make.right.mas_equalTo(contentView.mas_right).offset(-HMargin);
        make.left.mas_equalTo(contentView.mas_left).offset(HMargin);
    }];
    
    // 用户名
    UILabel *profileUsernameLabel = [[UILabel alloc] init];
    profileUsernameLabel.text = @"";
    profileUsernameLabel.textColor = [UIColor blackColor];
    profileUsernameLabel.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:profileUsernameLabel];
    _profileUsernameLabel = profileUsernameLabel;
    [profileUsernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(profileIconImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentView.mas_centerX);
    }];
    
    // 积分
    UILabel *proPointsLabel = [[UILabel alloc] init];
    proPointsLabel.text = @"积分：";
    proPointsLabel.textColor = [UIColor blackColor];
    proPointsLabel.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:proPointsLabel];
    [proPointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(profileUsernameLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentView.mas_centerX).offset(-40);
    }];
    _proPointsLabel = proPointsLabel;
    
    // 等级
    UILabel *proLevelLabel = [[UILabel alloc] init];
    proLevelLabel.text = @"等级：";
    proLevelLabel.textColor = [UIColor blackColor];
    proLevelLabel.font = [UIFont systemFontOfSize:12];
    [contentView addSubview:proLevelLabel];
    [proLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(profileUsernameLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(contentView.mas_centerX).offset(40);
    }];
    _proLevelLabel = proLevelLabel;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y - kOriOfftY;
    CGFloat h = kOriHeight - offset;
    if (h < 64) {
        h = 64;
    }
    [_profileContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
    
    CGFloat alph = offset * 1 / 38.0;
    if (alph >= 1) {
        alph = 0.99;
    }
    UILabel *titleLabel = (UILabel *)self.navigationItem.titleView;
    titleLabel.textColor = [UIColor colorWithWhite:0 alpha:alph];
    UIColor *alphColor = [UIColor colorWithRed:233/255.0 green:234/255.0 blue:235/255.0 alpha:alph];
    UIImage *alphImage = [UIImage imageWithColor:alphColor];
    [self.navigationController.navigationBar setBackgroundImage:alphImage forBarMetrics:UIBarMetricsDefault];
}

/**
 * 注册Cell
 */
- (void)registTableViewCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"FCProfileOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:profileOrderCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCProfileFunctionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:profileFunctionCellID];
}



#pragma mark - UITableView

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    if (section == 1) {
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
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else
        return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else
        return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FCProfileFunctionCell *functionCell = [tableView dequeueReusableCellWithIdentifier:profileFunctionCellID forIndexPath:indexPath];
        functionCell.delegate = self;
        functionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return functionCell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        }
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.cellDataArray[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            FCUploadProductViewController *vc = [[FCUploadProductViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if(indexPath.row == 1){
            FCProductDetailViewController *vc = [[FCProductDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma otherDelegate
// 红包卡券点击
- (void)couponsViewClick {
    FCCouPonsViewController *vc = [[FCCouPonsViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

// 浏览历史点击
- (void)browseHistoryViewClick {
    FCBrowseHistoryViewController *vc = [[FCBrowseHistoryViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

// 我的收藏点击
- (void)collectionViewClick {
    FCCollectionViewController *vc = [[FCCollectionViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击事件
// 客服
- (void)kefuButtonClick {
    NSLog(@"联系客服");
}

// 登录成功,重新布局
- (void)loginSuccess {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupAllViews];
    
    [self registTableViewCell];
    
    [self setupNotifications];
    //不自动调整scrollview内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view layoutIfNeeded];
}

// 退出账号,重新布局
- (void)exitAccount {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self setupVisitorView];
    [self.view layoutIfNeeded];
}

// 设置
- (void)settingButtonClick {
    FCSettingViewController *vc = [[FCSettingViewController alloc] init];
    // 退出登录的回调
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

// 访客视图---立即登录
- (void)loginButtonClick {
    FCLoginViewController *loginViewController = [[FCLoginViewController alloc] init];
    // 登录成功的回调
    RTRootNavigationController *loginNagigationContrller = [[RTRootNavigationController alloc] initWithRootViewController:loginViewController];
    loginNagigationContrller.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginNagigationContrller animated:YES completion:nil];
}

#pragma mark - 设置通知
- (void)setupNotifications {
    // 登录成功监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"LoginSuccessNotification" object:nil];
    // 退出登录监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitAccount) name:@"ExitAccountNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 数据

- (void)setUserData {
    YYCache *cache = [YYCache cacheWithName:@"USER_DATA_CACHE"];
    [cache containsObjectForKey:@"data" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        if (contains) {
            [cache objectForKey:@"data" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
                FCUserDataModel *data = (FCUserDataModel *)object;
                [cache setObject:data forKey:@"data" withBlock:^{
                    
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _profileUsernameLabel.text = data.nickname;
                });
            }];
        }
        else {
            NSString *token = [FCTokenManager getToken];
            NSString *urlString = [NSString stringWithFormat:@"%@%@",USER_DATA,token];
            [FCNetworkingManager getWithURLString:urlString parameters:nil success:^(id responseObject) {
                FCUserModel *model = [[FCUserModel alloc] initWithData:responseObject error:nil];
                FCUserDataModel *data = model.data;
                dispatch_async(dispatch_get_main_queue(), ^{
                    _profileUsernameLabel.text = data.nickname;
                });
                
            } failure:^(NSError *error) {
                NSLog(@"error: %@",error);
            }];
        }
    }];
    

}

#pragma mark - setter/getter

- (NSArray *)cellDataArray {
    if (_cellDataArray == nil) {
        NSArray *array = @[@"联系莲叶(上传商品临时入口)",@"莲叶承诺(商品详情临时入口)",@"关于莲叶"];
        _cellDataArray = [NSArray arrayWithArray:array];
    }
    return _cellDataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
