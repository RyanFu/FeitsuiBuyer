//
//  FCUploadProductViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/21.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCUploadProductViewController.h"
#import "FCDottedLineView.h"
#import "JNTextView.h"
#import "FCUploadProductCell.h"
#import "FCUploadProductModel.h"
#import <Masonry.h>

static const NSInteger kCategoryCount = 6;

@interface FCUploadProductViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) FCDottedLineView *addImageView;
@property (nonatomic, strong) FCDottedLineView *addVideoView;

// 价格
@property (nonatomic, strong) UITextField *priceTextField;
// 规格
@property (nonatomic, strong) UITextField *specificationTextField;
// 库存
@property (nonatomic, strong) UITextField *storesTextField;
// 商品描述
@property (nonatomic, strong) JNTextView *descriptionTextView;

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UIView *bottomContainer;

@property (nonatomic, strong) NSMutableArray *collectionDataArray;
// 存储选中的item
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) FCUploadProductCell *cell;

@end

@implementation FCUploadProductViewController

static NSString * const kCollectionViewCellID = @"FCUploadProductCell";
static NSString * const kCollectionHeaderViewID = @"FCUploadProductHeaderView";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTap)];
    [self.view addGestureRecognizer:tap];
    
    [self checkData];
    [self setupNavigationBar];
    [self setupAllViews];
}

// 收起键盘
- (void)fingerTap {
    [self.view endEditing:YES];
}

- (void)checkData {
    NSArray *titArray = @[@"题材",@"中水",@"颜色",@"价格",@"地区",@"第六个"];
    NSArray *array = @[@[@"全部",@"观音",@"佛",@"貔貅",@"如意"],@[@"全部",@"玻璃种",@"高斌中",@"冰种",@"冰怒中"],@[@"全部",@"浓阳绿",@"紫罗兰",@"墨绿",@"油青"],@[@"全部",@"0-3k",@"3-8k",@"8k1.5w",@"有四个字"],@[@"貔貅",@"如意",@"福瓜",@"平安扣",@"叶子"],@[@"全部",@"浓阳绿",@"紫罗兰",@"墨绿",@"油青"]];
    for(int i=0;i<titArray.count;i++){
        FCUploadProductModel *model = [[FCUploadProductModel alloc]init];
        model.title = titArray[i];
        model.categoryArray = array[i];
        [self.collectionDataArray addObject:model];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        [self.selectedArray addObject:indexPath];
    }
    
}


/**
 * 初始化 Navigationbar
 */
- (void)setupNavigationBar {
    self.navigationItem.title = @"新增商品";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 * 初始化所有View
 */
- (void)setupAllViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor colorWithRed:241/255.0 green:245/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _mainScrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    _containerView = containerView;
    
    // 商品名称
    JNTextView *nameTextView = [[JNTextView alloc] init];
    nameTextView.backgroundColor = [UIColor whiteColor];
    nameTextView.placeholder = @"请输入商品名称";
    nameTextView.placeholderColor = [UIColor lightGrayColor];
    nameTextView.font = [UIFont systemFontOfSize:13];
    [containerView addSubview:nameTextView];
    [nameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(containerView).offset(20);
        make.height.mas_equalTo(80);
    }];
    
    UIView *cutLine = [[UIView alloc] init];
    cutLine.backgroundColor = [UIColor colorWithRed:250/255.0 green:251/255.0 blue:251/255.0 alpha:1];
    [containerView addSubview:cutLine];
    [cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(nameTextView.mas_bottom);
        make.height.mas_equalTo(0.8);
    }];
    
    // 添加图片视频
    UIView *buttonContainerView = [[UIView alloc] init];
    buttonContainerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:buttonContainerView];
    [buttonContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(cutLine.mas_bottom);
        make.height.mas_equalTo(115);
    }];
    
    FCDottedLineView *addVideoView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FCDottedLineView class]) owner:self options:nil] lastObject];
    addVideoView.titleLabel.text = @"添加视频";
    UITapGestureRecognizer *addVideoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addVideoClick)];
    [addVideoView addGestureRecognizer:addVideoTap];
    [buttonContainerView addSubview:addVideoView];
    [addVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buttonContainerView.mas_left).offset(20);
        make.top.mas_equalTo(buttonContainerView.mas_top).offset(15);
        make.width.height.mas_equalTo(80);
    }];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor grayColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = [UIBezierPath bezierPathWithRect:addVideoView.bounds].CGPath;
    layer.frame = addVideoView.bounds;
    layer.lineWidth = 1.f;
    layer.lineDashPattern = @[@4, @2];
    [addVideoView.layer addSublayer:layer];
    _addVideoView = addVideoView;
    
    FCDottedLineView *addImageView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FCDottedLineView class]) owner:self options:nil] lastObject];
    addImageView.titleLabel.text = @"添加图片";
    UITapGestureRecognizer *addImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageClick)];
    [addImageView addGestureRecognizer:addImageTap];
    [buttonContainerView addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addVideoView.mas_right).offset(20);
        make.top.mas_equalTo(buttonContainerView.mas_top).offset(15);
        make.width.height.mas_equalTo(80);
    }];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.strokeColor = [UIColor grayColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [UIBezierPath bezierPathWithRect:addImageView.bounds].CGPath;
    layer2.frame = addImageView.bounds;
    layer2.lineWidth = 1.f;
    layer2.lineDashPattern = @[@4, @2];
    [addImageView.layer addSublayer:layer2];
    _addImageView = addImageView;
    
    // 价格
    UIView *priceContainerView = [[UIView alloc] init];
    priceContainerView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [containerView addSubview:priceContainerView];
    [priceContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(buttonContainerView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"价格：";
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    [priceContainerView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceContainerView.mas_left).offset(15);
        make.top.bottom.mas_equalTo(priceContainerView);
        make.width.mas_equalTo(60);
    }];
    
    UITextField *priceTextField = [[UITextField alloc] init];
    priceTextField.backgroundColor = [UIColor clearColor];
    priceTextField.textColor = [UIColor blackColor];
    priceTextField.font = [UIFont systemFontOfSize:14];
    priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    [priceContainerView addSubview:priceTextField];
    [priceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceLabel.mas_right).offset(5);
        make.right.top.bottom.mas_equalTo(priceContainerView);
    }];
    _priceTextField = priceTextField;
    
    // 规格
    UIView *specificationContainerView = [[UIView alloc] init];
    specificationContainerView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [containerView addSubview:specificationContainerView];
    [specificationContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(priceContainerView.mas_bottom).offset(2);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *specificationLabel = [[UILabel alloc] init];
    specificationLabel.text = @"规格：";
    specificationLabel.textColor = [UIColor blackColor];
    specificationLabel.font = [UIFont systemFontOfSize:14];
    [specificationContainerView addSubview:specificationLabel];
    [specificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(specificationContainerView.mas_left).offset(15);
        make.top.bottom.mas_equalTo(specificationContainerView);
        make.width.mas_equalTo(60);
    }];
    
    UITextField *specificationTextField = [[UITextField alloc] init];
    specificationTextField.backgroundColor = [UIColor clearColor];
    specificationTextField.textColor = [UIColor blackColor];
    specificationTextField.font = [UIFont systemFontOfSize:14];
    specificationTextField.keyboardType = UIKeyboardTypeDefault;
    [specificationContainerView addSubview:specificationTextField];
    [specificationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(specificationLabel.mas_right).offset(5);
        make.right.top.bottom.mas_equalTo(specificationContainerView);
    }];
    _specificationTextField = specificationTextField;
    
    // 库存
    UIView *storesContainerView = [[UIView alloc] init];
    storesContainerView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [containerView addSubview:storesContainerView];
    [storesContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(specificationContainerView.mas_bottom).offset(2);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *storesLabel = [[UILabel alloc] init];
    storesLabel.text = @"库存：";
    storesLabel.textColor = [UIColor blackColor];
    storesLabel.font = [UIFont systemFontOfSize:14];
    [storesContainerView addSubview:storesLabel];
    [storesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storesContainerView.mas_left).offset(15);
        make.top.bottom.mas_equalTo(storesContainerView);
        make.width.mas_equalTo(60);
    }];
    
    UITextField *storesTextField = [[UITextField alloc] init];
    storesTextField.backgroundColor = [UIColor clearColor];
    storesTextField.textColor = [UIColor blackColor];
    storesTextField.font = [UIFont systemFontOfSize:14];
    storesTextField.keyboardType = UIKeyboardTypeNumberPad;
    [storesContainerView addSubview:storesTextField];
    [storesTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storesLabel.mas_right).offset(5);
        make.right.top.bottom.mas_equalTo(storesContainerView);
    }];
    _storesTextField = storesTextField;
    
    // 商品描述
    UIView *descriptionContainerView = [[UIView alloc] init];
    descriptionContainerView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
    [containerView addSubview:descriptionContainerView];
    [descriptionContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(storesContainerView.mas_bottom).offset(2);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.text = @"商品描述：";
    descriptionLabel.textColor = [UIColor blackColor];
    descriptionLabel.font = [UIFont systemFontOfSize:14];
    [descriptionContainerView addSubview:descriptionLabel];
    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descriptionContainerView.mas_left).offset(15);
        make.top.bottom.mas_equalTo(descriptionContainerView);
        make.width.mas_equalTo(80);
    }];
    
    JNTextView *descriptionTextView = [[JNTextView alloc] init];
    descriptionTextView.backgroundColor = [UIColor clearColor];
    descriptionTextView.textColor = [UIColor blackColor];
    descriptionTextView.font = [UIFont systemFontOfSize:14];
    [descriptionContainerView addSubview:descriptionTextView];
    [descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(descriptionLabel.mas_right).offset(5);
        make.right.top.bottom.mas_equalTo(descriptionContainerView);
    }];
    _descriptionTextView = descriptionTextView;

    
    // 底部button
    
    UIView *bottomContainer = [[UIView alloc] init];
    bottomContainer.backgroundColor = [UIColor clearColor];
    [containerView addSubview:bottomContainer];
    [bottomContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(containerView.mas_bottom);
    }];
    _bottomContainer = bottomContainer;
    
    UIButton *upButton = [[UIButton alloc] init];
    [upButton setTitle:@"上架出售" forState:UIControlStateNormal];
    [upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upButton setBackgroundColor:[UIColor colorWithRed:249/255.0 green:83/255.0 blue:84/255.0 alpha:1]];
    [upButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [upButton.layer setCornerRadius:5];
    [upButton.layer setMasksToBounds:YES];
    [upButton addTarget:self action:@selector(upButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomContainer addSubview:upButton];
    [upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomContainer.mas_centerY);
        make.height.mas_equalTo(30);
        make.left.mas_equalTo(bottomContainer.mas_left).offset(10);
    }];
    
    UIButton *storeButton = [[UIButton alloc] init];
    [storeButton setTitle:@"放入仓库" forState:UIControlStateNormal];
    [storeButton setTitleColor:[UIColor colorWithRed:249/255.0 green:83/255.0 blue:84/255.0 alpha:1] forState:UIControlStateNormal];
    [storeButton setBackgroundColor:[UIColor whiteColor]];
    [storeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [storeButton.layer setCornerRadius:5];
    [storeButton.layer setMasksToBounds:YES];
    [storeButton addTarget:self action:@selector(storeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomContainer addSubview:storeButton];
    [storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomContainer.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(bottomContainer.mas_right).offset(-10);
        make.left.mas_equalTo(upButton.mas_right).offset(10);
        make.width.mas_equalTo(upButton.mas_width);
    }];
    
    // collectionView
    [self setupCollectionView];
    
}

- (void)addVideoClick {
    NSLog(@"addVideoClick");
}

- (void)addImageClick {
    NSLog(@"addImageClick");
}

- (void)upButtonClick {
    NSLog(@"upButtonClick");
}

- (void)storeButtonClick {
    NSLog(@"storeButtonClick");
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 35)/5, 30);
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.minimumLineSpacing = 5;
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
    
    UICollectionView *mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    mainCollectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    mainCollectionView.scrollEnabled = NO;
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    [mainCollectionView registerClass:[FCUploadProductCell class] forCellWithReuseIdentifier:kCollectionViewCellID];
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderViewID];
    [self.mainScrollView addSubview:mainCollectionView];
    [mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.descriptionTextView.mas_bottom);
        make.bottom.mas_equalTo(self.bottomContainer.mas_top);
        make.height.mas_equalTo((30 + 60) * kCategoryCount + 40);
    }];
    _mainCollectionView = mainCollectionView;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.collectionDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    FCUploadProductModel *model = self.collectionDataArray[section];
    return model.categoryArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderViewID forIndexPath:indexPath];
    FCUploadProductModel *model = self.collectionDataArray[indexPath.section];
    UILabel *label;
    if (headerView.subviews.count == 0) {
        
        UIView *square = [[UIView alloc] init];
        
        square.backgroundColor = [UIColor whiteColor];
        square.layer.borderColor = [UIColor blackColor].CGColor;
        square.layer.borderWidth = 1.f;
        [headerView addSubview:square];
        [square mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerView).offset(10);
            make.centerY.mas_equalTo(headerView.mas_centerY);
            make.height.width.mas_equalTo(10);
        }];
        
        
        label = [[UILabel alloc] init];
        [headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(square.mas_right).offset(10);
            make.centerY.mas_equalTo(headerView.mas_centerY);
            make.top.bottom.mas_equalTo(headerView);
        }];
        label.font = [UIFont systemFontOfSize:12.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.text = model.title;
        
    }
    else {
        for (UIView *view in headerView.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)view;
                label.text = model.title;
            }
        }
    }
    return headerView;
    
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCUploadProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellID forIndexPath:indexPath];
    FCUploadProductModel *model = self.collectionDataArray[indexPath.section];
    [cell loadViewWithInfo:model.categoryArray[indexPath.row]];
    
    for(NSIndexPath *index in self.selectedArray){
        if(index.section == indexPath.section){
            if(index.row == indexPath.row){
                cell.contentView.backgroundColor = [UIColor grayColor];
            }
            else{
                cell.contentView.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:238/255.0 alpha:1];
            }
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for(NSIndexPath *index in self.selectedArray){
        if(index.section == indexPath.section){
            [self.selectedArray removeObject:index];
            break;
        }
    }
    ///这句代码不加在for循环里是因为每个section都比由一个选中的，也就是比由一个会被remove，所以在这里加addobject
    [self.selectedArray addObject:indexPath];
    ///这里可以选则只单独刷新那个section
    [collectionView reloadData];
}


- (NSMutableArray *)collectionDataArray {
    if (_collectionDataArray == nil) {
        _collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

@end
