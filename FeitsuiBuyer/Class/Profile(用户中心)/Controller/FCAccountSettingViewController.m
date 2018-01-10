//
//  FCAccountSettingViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/11/28.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCAccountSettingViewController.h"
#import "FCAccountTouxiangCell.h"
#import "FCModifyTelViewController.h"
#import "FCModifyNameViewController.h"
#import "FCUserModel.h"
#import "FCUserDataModel.h"
#import "FCNetworkingManager.h"
#import "FCTokenManager.h"
#import "FCUploadImageParams.h"
#import <UIImageView+GDWebCache.h>
#import <YYCache.h>

@interface FCAccountSettingViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSCoding>

@property (nonatomic, strong) NSArray *cellDataArray;

@property (nonatomic, strong) UIImage *myImage;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, strong) FCAccountTouxiangCell *accountTouxiangCell;

@property (nonatomic, strong) FCUserModel *model;

@property (nonatomic, strong) FCUserDataModel *data;

@end

@implementation FCAccountSettingViewController
static NSString * const accountTouxiangCellID = @"accountTouxiangCellID";
static NSString * const normalCellID = @"normalCellID";

- (NSArray *)cellDataArray {
    if (_cellDataArray == nil) {
        NSArray *array = @[@"昵称",@"绑定/修改邮箱"];
        _cellDataArray = [NSArray arrayWithArray:array];
    }
    return _cellDataArray;
}

/**
 * 设置状态栏字体颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FCAccountTouxiangCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:accountTouxiangCellID];
}


/**
 * 初始化NavigationBar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"个人设置";
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


#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else
        return 2;
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        FCAccountTouxiangCell *accountTouxinagCell = [tableView dequeueReusableCellWithIdentifier:accountTouxiangCellID forIndexPath:indexPath];
        accountTouxinagCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSString *userURL = [NSString stringWithFormat:@"%@/%@",BASE_URL,_data.logo];
        NSLog(@"%@",userURL);
        [accountTouxinagCell.touxiangImageView gd_setLowCompressImageWithUrl:userURL placeholder:nil];
        _accountTouxiangCell = accountTouxinagCell;
        return accountTouxinagCell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:normalCellID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.cellDataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor blackColor];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = _data.nickname;
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = _data.email;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self setTouxiangImage];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            FCModifyNameViewController *vc = [[FCModifyNameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            FCModifyTelViewController *vc = [[FCModifyTelViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)setTouxiangImage {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"更换头像"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 4)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    [alertVC setValue:alertControllerStr forKey:@"attributedTitle"];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
//        [self selectImageFromCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        [self selectImageFromLibrary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:photoAction];
    [alertVC addAction:albumAction];
    [alertVC addAction:cancelAction];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - 从摄像头获取图片或视频
/**
 * 从相机获取头像
 */
- (void)selectImageFromCamera {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

/**
 * 从相册获取头像
 */
- (void)selectImageFromLibrary {
    //相册没有相片
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"相册没有照片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return;
        }];
        [alertVC addAction:action];
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    _accountTouxiangCell.touxiangImageView.image = info[UIImagePickerControllerOriginalImage];
    
    [self uploadLogo];
}

#pragma mark - 数据

/**
 * 加载数据
 */
- (void)checkData {
//    NSString *token = [FCTokenManager getToken];
//    NSString *userURL = [NSString stringWithFormat:@"%@%@",USER_DATA,token];
//    __block FCUserModel *model;
//    __block FCUserDataModel *data;
//    [FCNetworkingManager getWithURLString:userURL parameters:nil success:^(id responseObject) {
//        model = [[FCUserModel alloc] initWithData:responseObject error:nil];
//        data = model.data;
//        _data = data;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//
//    }];
    
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
 * 上传头像
 */
- (void)uploadLogo {
    NSString *token = [FCTokenManager getToken];
    NSString *url = [NSString stringWithFormat:@"%@%@",EDIT_USER_LOGO,token];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    FCUploadImageParams *imageParams = [[FCUploadImageParams alloc] init];
    UIImage *image = _accountTouxiangCell.touxiangImageView.image;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.005);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",[formatter stringFromDate:[NSDate date]]];
    
    imageParams.data = imageData;
    imageParams.name = @"logo";
    imageParams.filename = fileName;
    imageParams.mimeType = @"image/jpg";
    
    parameters[@"logo"] = fileName;
    
    
    [FCNetworkingManager uploadWithURLString:url parameters:parameters uploadParam:imageParams success:^(id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"response: %@",dict);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error: %@",error);
    }];
    
}

@end
