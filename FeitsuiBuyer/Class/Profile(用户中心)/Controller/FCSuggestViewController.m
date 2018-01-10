//
//  FCSuggestViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/1.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSuggestViewController.h"
#import "JNTextView.h"
#import <Masonry.h>

@interface FCSuggestViewController ()<UITextViewDelegate>

@property (nonatomic, strong)JNTextView *contentTextView;

@property (nonatomic, strong)UILabel *totalWordsLabel;

@property (nonatomic, strong)UITextField *numberTextField;

@end

@implementation FCSuggestViewController


/**
 * 设置状态栏颜色状态
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

/**
 * 初始化navigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"意见建议";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *commitButton = [[UIButton alloc] init];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton.layer setBorderWidth:1];
    [commitButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    commitButton.layer.cornerRadius = 2;
    commitButton.layer.masksToBounds = YES;
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: commitButton];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitButtonClick {
    if (self.contentTextView.text.length > 140) {
        NSLog(@"提交字数请在140字以内");
    }
    else {
        NSLog(@"提交");
    }
}


/**
 * 初始化所有View
 */
- (void)setupAllViews {
    JNTextView *contentTextView = [[JNTextView alloc] init];
    contentTextView.backgroundColor = [UIColor whiteColor];
    contentTextView.textColor = [UIColor blackColor];
    contentTextView.font = [UIFont systemFontOfSize:13];
    contentTextView.placeholder = @"  您可以输入您的意见和反馈";
    contentTextView.placeholderColor = [UIColor lightGrayColor];
    contentTextView.delegate = self;
    [self.view addSubview:contentTextView];
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(240);
    }];
    _contentTextView = contentTextView;
    
    UILabel *totalWordsLabel = [[UILabel alloc] init];
    totalWordsLabel.text = @"0/140";
    totalWordsLabel.textColor = [UIColor lightGrayColor];
    totalWordsLabel.font = [UIFont systemFontOfSize:10];
    [totalWordsLabel sizeToFit];
    [self.view addSubview:totalWordsLabel];
    [totalWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(contentTextView.mas_right).offset(-10);
        make.bottom.mas_equalTo(contentTextView.mas_bottom).offset(-5);
    }];
    _totalWordsLabel = totalWordsLabel;
    
    UITextField *numberTextField = [[UITextField alloc] init];
    numberTextField.backgroundColor = [UIColor whiteColor];
    numberTextField.textColor = [UIColor blackColor];
    numberTextField.placeholder = @"  请输入手机号码或QQ号";
    numberTextField.font = [UIFont systemFontOfSize:13];
    numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:numberTextField];
    [numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
    }];
    _numberTextField = numberTextField;
}

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger wordCount = textView.text.length;
    
    //字数限制140
    if (wordCount > 140) {
        NSInteger overWordCount = wordCount - 140;
        self.totalWordsLabel.text = [NSString stringWithFormat:@"-%ld/140",overWordCount];
        self.totalWordsLabel.textColor = [UIColor redColor];
    }
    else {
        self.totalWordsLabel.text = [NSString stringWithFormat:@"%ld/140",wordCount];
        self.totalWordsLabel.textColor = [UIColor lightGrayColor];
    }
}

// 收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
