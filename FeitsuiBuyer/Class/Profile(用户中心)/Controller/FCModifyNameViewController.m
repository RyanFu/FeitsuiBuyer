//
//  FCModifyNameViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/29.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCModifyNameViewController.h"
#import "FCUserModel.h"
#import "FCUserDataModel.h"
#import "FCNetworkingManager.h"
#import "FCTokenManager.h"
#import <Masonry.h>
#import <YYCache.h>

@interface FCModifyNameViewController ()

@property (nonatomic, strong) UITextField *nameTextField;



@end

@implementation FCModifyNameViewController

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    [self checkData];
    
    [self setupNavigationBar];
    
    [self setupAllViews];
}

/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"修改昵称";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *saveButton = [[UIButton alloc] init];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton.layer setBorderWidth:0.5];
    [saveButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    saveButton.layer.cornerRadius = 3;
    saveButton.layer.masksToBounds = YES;
    [saveButton addTarget:self
                   action:@selector(save)
         forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 布局界面
 */
- (void)setupAllViews {
    UITextField *contentTextField = [[UITextField alloc] init];
    contentTextField.backgroundColor = [UIColor whiteColor];
    contentTextField.font = [UIFont systemFontOfSize:14];
    contentTextField.textColor = [UIColor darkGrayColor];
    contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:contentTextField];
    [contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(74);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
    }];
    _nameTextField = contentTextField;
}

// 收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - 数据

/**
 * 加载数据
 */
- (void)checkData {
    NSString *token = [FCTokenManager getToken];
    NSString *userURL = [NSString stringWithFormat:@"%@%@",USER_DATA,token];
    
    [FCNetworkingManager getWithURLString:userURL parameters:nil success:^(id responseObject) {
        FCUserModel *model = [[FCUserModel alloc] initWithData:responseObject error:nil];
        FCUserDataModel *data = model.data;
        _nameTextField.text = data.nickname;
    } failure:^(NSError *error) {
        
    }];
    
    YYCache *cache = [YYCache cacheWithName:@"USER_DATA_CACHE"];
    [cache containsObjectForKey:@"data" withBlock:^(NSString * _Nonnull key, BOOL contains) {
        if (contains) {
            [cache objectForKey:@"data" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
                FCUserDataModel *data = (FCUserDataModel *)object;
                // 刷新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    _nameTextField.text = data.nickname;
                });
            }];
        }
        else {
            NSString *token = [FCTokenManager getToken];
            NSString *userURL = [NSString stringWithFormat:@"%@%@",USER_DATA,token];
            
            [FCNetworkingManager getWithURLString:userURL parameters:nil success:^(id responseObject) {
                FCUserModel *model = [[FCUserModel alloc] initWithData:responseObject error:nil];
                FCUserDataModel *data = model.data;
                [cache setObject:data forKey:@"data" withBlock:^{
                    
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _nameTextField.text = data.nickname;
                });
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}


/**
 * 保存昵称
 */
- (void)save {
    NSString *token = [FCTokenManager getToken];
    NSString *editUserNameURL = [NSString stringWithFormat:@"%@%@",EDIT_USER_NAME,token];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"nickname"] = _nameTextField.text;
    [FCNetworkingManager postWithURLString:editUserNameURL parameters:parameters success:^(id responseObject) {
        FCUserModel *model = [[FCUserModel alloc] initWithData:responseObject error:nil];
        YYCache *cache = [YYCache cacheWithName:@"USER_DATA_CACHE"];
        [cache setObject:model.data forKey:@"data" withBlock:^{
            
        }];
        [self back];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

@end
