//
//  FCRegisterViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/25.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCRegisterViewController.h"
#import "UIImage+Extension.h"
#import "FCNetworkingManager.h"
#import "FCRegisterModel.h"
#import "FCRegisterDataModel.h"
#import <Masonry.h>
#import <MBProgressHUD.h>


@interface FCRegisterViewController ()

// 手机号
@property (nonatomic, strong) UITextField *telTextField;

// 密码
@property (nonatomic, strong) UITextField *passwordTextField;

@end

@implementation FCRegisterViewController

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
    [settingButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [settingButton setBackgroundColor:[UIColor clearColor]];
    [settingButton sizeToFit];
    [settingButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
}

- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupAllView];
}

- (void)setupAllView {
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"11123201202091437392791.jpg"];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIView *loginContainer = [[UIView alloc] init];
    loginContainer.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loginContainer];
    [loginContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(80);
    }];
    
    // 手机号
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = @"手机号";
    telLabel.textColor = [UIColor whiteColor];
    telLabel.font = [UIFont systemFontOfSize:14];
    [loginContainer addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginContainer.mas_left);
        make.top.mas_equalTo(loginContainer.mas_top);
        make.height.mas_equalTo(loginContainer.mas_height).multipliedBy(0.5);
        make.width.mas_equalTo(loginContainer.mas_width).multipliedBy(0.2);
    }];
    
    UITextField *telTextField = [[UITextField alloc] init];
    telTextField.backgroundColor = [UIColor clearColor];
    
    NSString *placeholderString = @"请输入手机号";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:placeholderString];
    [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, placeholderString.length)];
    [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, placeholderString.length)];
    
    telTextField.attributedPlaceholder = placeholder;
    telTextField.textColor = [UIColor whiteColor];
    telTextField.font = [UIFont systemFontOfSize:14];
    [loginContainer addSubview:telTextField];
    [telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(telLabel.mas_right);
        make.top.mas_equalTo(loginContainer.mas_top);
        make.right.mas_equalTo(loginContainer.mas_right);
        make.height.mas_equalTo(loginContainer.mas_height).multipliedBy(0.5);
    }];
    _telTextField = telTextField;
    
    // 分割线1
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [loginContainer addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(loginContainer);
        make.top.mas_equalTo(telTextField.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    // 分割线2
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    [loginContainer addSubview: bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(loginContainer);
        make.bottom.mas_equalTo(loginContainer.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    // 密码
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码";
    passwordLabel.textColor = [UIColor whiteColor];
    passwordLabel.font = [UIFont systemFontOfSize:14];
    [loginContainer addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(loginContainer.mas_left);
        make.top.mas_equalTo(line);
        make.bottom.mas_equalTo(bottomLine);
        make.width.mas_equalTo(loginContainer.mas_width).multipliedBy(0.2);
    }];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.backgroundColor = [UIColor clearColor];
    
    NSString *placeholderString2 = @"请输入密码";
    NSMutableAttributedString *placeholder2 = [[NSMutableAttributedString alloc] initWithString:placeholderString2];
    [placeholder2 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, placeholderString2.length)];
    [placeholder2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, placeholderString2.length)];
    
    passwordTextField.attributedPlaceholder = placeholder2;
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont systemFontOfSize:14];
    [loginContainer addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordLabel.mas_right);
        make.top.mas_equalTo(line);
        make.bottom.mas_equalTo(bottomLine);
        make.right.mas_equalTo(loginContainer.mas_right);
    }];
    _passwordTextField = passwordTextField;
    
    UIButton *loginButton = [[UIButton alloc] init];
    [loginButton setBackgroundColor:[UIColor colorWithRed:0 green:56/255.0 blue:10/255.0 alpha:0.6]];
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [loginButton.titleLabel setTextColor:[UIColor whiteColor]];
    [loginButton.layer setCornerRadius:5.f];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(loginContainer);
        make.top.mas_equalTo(loginContainer.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    
}

// 注册
- (void)registerButtonClick {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"telphone"] = _telTextField.text;
    parameters[@"password"] = _passwordTextField.text;
    [FCNetworkingManager postWithURLString:USER_REGISTER parameters:parameters success:^(id responseObject) {
        FCRegisterModel *model = [[FCRegisterModel alloc] initWithData:responseObject error:nil];
        if (model.code == 200) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // hanlder
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setBool:YES forKey:@"is_login"];
                
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, 1.3 * NSEC_PER_SEC);
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }];
            [alertVC addAction:determineAction];
            
            [self.navigationController presentViewController:alertVC animated:YES completion:nil];
        }
        else {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"手机号已被注册!";
            hud.removeFromSuperViewOnHide = YES;
            [hud hideAnimated:YES afterDelay:1.0];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
