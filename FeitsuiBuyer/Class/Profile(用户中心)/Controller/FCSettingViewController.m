//
//  FCSettingViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/28.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSettingViewController.h"
#import "FCAccountSettingViewController.h"
#import "FCSuggestViewController.h"
#import "FCNetworkingManager.h"
#import "FCTokenManager.h"
#import "FCLoginModel.h"
#import "FCHomeViewController.h"
#import <GDWebCache.h>
#import <Masonry.h>
#import <CYLTabBarController.h>

@interface FCSettingViewController ()

@property (nonatomic, strong)NSDictionary *cellDataDict;

@end

@implementation FCSettingViewController

- (NSDictionary *)cellDataDict {
    if (_cellDataDict == nil) {
        NSDictionary *dict = @{
                               @"section0":@[@"账号设置"],
                               @"section1":@[@"意见反馈",@"清除缓存",@"声明",@"说明"]
                               };
        _cellDataDict = [NSDictionary dictionaryWithDictionary:dict];
    }
    return _cellDataDict;
}

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupNavigationBar];
}


/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置";
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

#pragma mark - UITableView

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *footer = [[UIView alloc] init];
        
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(footer);
            make.height.mas_equalTo(40);
            make.bottom.mas_equalTo(footer.mas_bottom);
        }];
        return footer;
    }
    else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else
        return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDataDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = self.cellDataDict[@"section0"][indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = self.cellDataDict[@"section1"][indexPath.row];
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ldM",[GDWebCache calculateAllCachedSize]];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //账号设置
    if (indexPath.section == 0) {
        FCAccountSettingViewController *vc = [[FCAccountSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FCSuggestViewController *vc = [[FCSuggestViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        //清除缓存
        if (indexPath.row == 1) {
            [self cleanCacheAlert];
        }
    }
}

/**
 * cache
 */
- (void)cleanCacheAlert {
    NSString *alertMessage = [NSString stringWithFormat:@"共有(%ldM)缓存，确定清除这些缓存吗?",[GDWebCache calculateAllCachedSize]];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"清除缓存" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [GDWebCache cleanCachedImageDataWithCompletionBlock:^{
            
        }];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:determineAction];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}


/**
 * 退出登录
 */
- (void)logout {
    // 刷新一下token
    NSString *token = [FCTokenManager getToken];
    NSString *url = [NSString stringWithFormat:@"%@%@",REFRESH_TOKEN,token];
    [FCNetworkingManager getWithURLString:url parameters:nil success:^(id responseObject) {
        FCLoginModel *model = [[FCLoginModel alloc] initWithData:responseObject error:nil];
        [FCTokenManager saveToken:model.data];
    } failure:^(NSError *error) {
        
    }];
    
    // 退出登录 监听
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ExitAccountNotification" object:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"is_login"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backToRootViewController{
    UIViewController* vc = self;
    if ([vc isEqual:[CYLTabBarController new]]) return;
    if (vc.presentingViewController) {
        [vc dismissViewControllerAnimated:NO completion:^{
            [self backToRootViewController];
        }];
    }
    else{
        [vc.navigationController popViewControllerAnimated:NO];
        [self backToRootViewController];
    }
}


@end
