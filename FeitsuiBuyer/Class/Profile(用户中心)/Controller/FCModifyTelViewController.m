//
//  FCModifyTelViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/29.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCModifyTelViewController.h"
#import "FCModifyTelCell.h"
#import "FCAuthCodeCell.h"
#import "FCUserModel.h"
#import "FCUserDataModel.h"
#import "FCNetworkingManager.h"
#import "FCTokenManager.h"
#import <Masonry.h>
#import <YYCache.h>

#define kDeterminButtonColor [UIColor colorWithRed:255/255.0 green:90/255.0 blue:73/255.0 alpha:1]

@interface FCModifyTelViewController ()

@property (nonatomic, strong)FCModifyTelCell *modifyTelCell;

@property (nonatomic, strong) FCUserModel *model;

@property (nonatomic, strong) FCUserDataModel *data;

@end

@implementation FCModifyTelViewController

static NSString * const modifyTelCellID = @"modifyTelCellID";
static NSString * const authCodeCellID = @"authCodeCellID";
static NSString * const normalCellID = @"normalCellID";

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 * 收起键盘
 */
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self checkData];
    [self setupTableView];
    [self setupNavigationBar];
}


/**
 * 初始化tableView
 */
- (void)setupTableView {
    
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FCModifyTelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:modifyTelCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCAuthCodeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:authCodeCellID];
}

/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"修改邮箱";
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
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        UIButton *determineButton = [[UIButton alloc] init];
        [determineButton setTitle:@"确定" forState:UIControlStateNormal];
        determineButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [determineButton setTitleColor:kDeterminButtonColor forState:UIControlStateNormal];
        [determineButton setBackgroundColor:[UIColor clearColor]];
        [determineButton.layer setBorderWidth:0.5];
        [determineButton.layer setBorderColor:kDeterminButtonColor.CGColor];
        determineButton.layer.cornerRadius = 15;
        determineButton.layer.masksToBounds = YES;
        [determineButton addTarget:self action:@selector(determineButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:determineButton];
        [determineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view.mas_top).offset(30);
            make.bottom.mas_equalTo(view.mas_bottom);
            make.left.mas_equalTo(view.mas_left).offset(15);
            make.right.mas_equalTo(view.mas_right).offset(-15);
        }];
        return view;
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
        return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        _modifyTelCell = [tableView dequeueReusableCellWithIdentifier:modifyTelCellID forIndexPath:indexPath];
        _modifyTelCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _modifyTelCell;
    }
    else {
        UITableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellID];
        if (normalCell == nil) {
            normalCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCellID];
        }
        normalCell.textLabel.text = [NSString stringWithFormat:@"当前邮箱：%@",_data.email];
        normalCell.textLabel.textColor = [UIColor darkGrayColor];
        normalCell.textLabel.font = [UIFont systemFontOfSize:14];
        normalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return normalCell;
    }
}

#pragma mark - 数据
- (void)checkData {
    
    YYCache *cache = [YYCache cacheWithName:@"USER_DATA_CACHE"];
    [cache containsObjectForKey:@"data" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        if (contains) {
            [cache objectForKey:@"data" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
                _data = (FCUserDataModel *)object;
                // 刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }];
        }
        else {
            NSString *token = [FCTokenManager getToken];
            NSString *userURL = [NSString stringWithFormat:@"%@%@",USER_DATA,token];
            
            [FCNetworkingManager getWithURLString:userURL parameters:nil success:^(id responseObject) {
                _model = [[FCUserModel alloc] initWithData:responseObject error:nil];
                _data = _model.data;
                [cache setObject:_data forKey:@"data" withBlock:^{
                    
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}


/**
 * 保存邮箱
 */
- (void)determineButtonClick {
    NSString *token = [FCTokenManager getToken];
    NSString *editUserNameURL = [NSString stringWithFormat:@"%@%@",EDIT_USER_NAME,token];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"email"] = _modifyTelCell.telTextField.text;
    [FCNetworkingManager postWithURLString:editUserNameURL parameters:parameters success:^(id responseObject) {
        FCUserModel *model = [[FCUserModel alloc] initWithData:responseObject error:nil];
        YYCache *cache = [YYCache cacheWithName:@"USER_DATA_CACHE"];
        [cache setObject:model.data forKey:@"data" withBlock:^{
            
        }];
        [self back];
    } failure:^(NSError *error) {

    }];
}


@end
