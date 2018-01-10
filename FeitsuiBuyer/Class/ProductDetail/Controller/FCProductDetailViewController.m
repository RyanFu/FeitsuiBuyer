//
//  FCProductDetailViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/22.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCProductDetailViewController.h"
#import "FCProductRecommendCell.h"
#import "FCBottomFunctionView.h"
#import <Masonry.h>

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 商品推荐collectionView
static const CGFloat kProductCollectionItemWidth = 180.0;
static const CGFloat kProductCollectionItemHeight = 240.0;
static const NSInteger kProductCount = 8;

@interface FCProductDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *mainCollectionView;
// 视频图片
@property (nonatomic, strong) UIImageView *videoPlayImageView;
// 商品图片
@property (nonatomic, strong) UIImageView *productImageView;
// 商品名称
@property (nonatomic, strong) UILabel *nameText;
// 商品价格
@property (nonatomic, strong) UILabel *priceText;
// 商品编号
@property (nonatomic, strong) UILabel *numberText;
// 商品重量
@property (nonatomic, strong) UILabel *weightText;
// 商品尺寸
@property (nonatomic, strong) UILabel *sizeText;
// 商品库存
@property (nonatomic, strong) UILabel *storeText;
// 商品说明
@property (nonatomic, strong) UILabel *describeText;
// 商家保证图片1
@property (nonatomic, strong) UIImageView *imageView1;
// 商家保证图片2
@property (nonatomic, strong) UIImageView *imageView2;
// 商家保证图片3
@property (nonatomic, strong) UIImageView *imageView3;
// 商家保证图片4
@property (nonatomic, strong) UIImageView *imageView4;
// 商家保证图片5
@property (nonatomic, strong) UIImageView *imageView5;
// 商家保证图片6
@property (nonatomic, strong) UIImageView *imageView6;

@end

@implementation FCProductDetailViewController

static NSString * const productRecommendCellID = @"productRecommendCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupAllViews];
}

/**
 * 初始化 Navigationbar
 */
- (void)setupNavigationBar {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"宝贝详情";
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"转发"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick)];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick {
    NSLog(@"rightBarButtonClick");
}

- (void)setupAllViews {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    
    // 视频
    UIView *videoPlayView = [[UIView alloc] init];
    [scrollView addSubview:videoPlayView];
    [videoPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(containerView.mas_top).offset(2);
        make.height.mas_equalTo(videoPlayView.mas_width).multipliedBy(0.8);
    }];
    
    UIImageView *videoPlayImageView = [[UIImageView alloc] init];
    videoPlayImageView.image = [UIImage imageNamed:@"11123201202091437392791.jpg"];
    [videoPlayView addSubview:videoPlayImageView];
    [videoPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(videoPlayView);
    }];
    
    UIButton *videoPlayButton = [[UIButton alloc] init];
    [videoPlayButton setBackgroundColor:[UIColor whiteColor]];
    [videoPlayButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [videoPlayButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [videoPlayButton addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [videoPlayButton.layer setCornerRadius:25.f];
    [videoPlayButton.layer setMasksToBounds:YES];
    [videoPlayView addSubview:videoPlayButton];
    [videoPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(videoPlayView.mas_centerX);
        make.centerY.mas_equalTo(videoPlayView.mas_centerY);
        make.width.height.mas_equalTo(50);
    }];
    
    // 图片
    UIImageView *productImageView = [[UIImageView alloc] init];
    productImageView.image = [UIImage imageNamed:@"11123201202091437392791.jpg"];
    productImageView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:productImageView];
    [productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(videoPlayView.mas_bottom).offset(2);
        make.height.mas_equalTo(productImageView.mas_width).multipliedBy(0.8);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"冰种春带彩手镯";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:14];
    [containerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView.mas_left).offset(10);
        make.top.mas_equalTo(productImageView.mas_bottom).offset(5);
    }];
    _nameText = nameLabel;

    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.text = @"¥88888";
    priceLabel.textColor = [UIColor colorWithRed:205/255.0 green:0 blue:0 alpha:1];
    priceLabel.font = [UIFont systemFontOfSize:14];
    [containerView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(containerView.mas_left).offset(10);
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(2);
    }];
    _priceText = priceLabel;

    // 编号
    UIView *numberView = [[UIView alloc] init];
    numberView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:numberView];
    [numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(8);
    }];

    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.text = @"【编号】：";
    numberLabel.textColor = [UIColor blackColor];
    numberLabel.font = [UIFont systemFontOfSize:14];
    [numberLabel sizeToFit];
    [numberView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(numberView);
    }];
    UILabel *numberText = [[UILabel alloc] init];
    numberText.backgroundColor = [UIColor whiteColor];
    [numberView addSubview:numberText];
    [numberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(numberLabel.mas_right).offset(5);
        make.top.bottom.right.mas_equalTo(numberView);
    }];
    _nameText = numberText;

    // 尺寸
    UIView *sizeView = [[UIView alloc] init];
    sizeView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:sizeView];
    [sizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(numberView.mas_bottom);
    }];

    UILabel *sizeLabel = [[UILabel alloc] init];
    sizeLabel.text = @"【尺寸】：";
    sizeLabel.textColor = [UIColor blackColor];
    sizeLabel.font = [UIFont systemFontOfSize:14];
    [sizeView addSubview:sizeLabel];
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sizeView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(sizeView);
    }];

    UILabel *sizeText = [[UILabel alloc] init];
    sizeText.backgroundColor = [UIColor whiteColor];
    [sizeView addSubview:sizeText];
    [sizeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sizeLabel.mas_right).offset(5);
        make.top.bottom.right.mas_equalTo(sizeView);
    }];
    _sizeText = sizeText;

    // 重量
    UIView *weightView = [[UIView alloc] init];
    weightView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:weightView];
    [weightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(sizeView.mas_bottom);
    }];

    UILabel *weightLabel = [[UILabel alloc] init];
    weightLabel.text = @"【重量】：";
    weightLabel.textColor = [UIColor blackColor];
    weightLabel.font = [UIFont systemFontOfSize:14];
    [weightView addSubview:weightLabel];
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weightView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(weightView);
    }];

    UILabel *weightText = [[UILabel alloc] init];
    weightText.backgroundColor = [UIColor whiteColor];
    [weightView addSubview:weightText];
    [weightText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weightLabel.mas_right).offset(5);
        make.top.bottom.right.mas_equalTo(weightView);
    }];
    _weightText = weightText;

    // 库存
    UIView *storesView = [[UIView alloc] init];
    storesView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:storesView];
    [storesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(weightView.mas_bottom);
    }];

    UILabel *storesLabel = [[UILabel alloc] init];
    storesLabel.text = @"【库存】：";
    storesLabel.textColor = [UIColor blackColor];
    storesLabel.font = [UIFont systemFontOfSize:14];
    [storesView addSubview:storesLabel];
    [storesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storesView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(storesView);
    }];
    UILabel *storesText = [[UILabel alloc] init];
    storesText.backgroundColor = [UIColor whiteColor];
    [storesView addSubview:storesText];
    [storesText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(storesLabel.mas_right).offset(5);
        make.top.bottom.right.mas_equalTo(storesView);
    }];
    _storeText = storesText;


    // 说明
    UIView *describeView = [[UIView alloc] init];
    describeView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:describeView];
    [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(storesView.mas_bottom);
    }];

    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.text = @"【说明】：";
    describeLabel.textColor = [UIColor blackColor];
    describeLabel.font = [UIFont systemFontOfSize:14];
    [describeView addSubview:describeLabel];
    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(describeView.mas_left).offset(10);
        make.top.bottom.mas_equalTo(describeView);
    }];

    UILabel *describeText = [[UILabel alloc] init];
    describeText.backgroundColor = [UIColor whiteColor];
    [describeView addSubview:describeText];
    [describeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(describeLabel.mas_right).offset(5);
        make.top.bottom.right.mas_equalTo(describeView);
    }];
    _describeText = describeText;
    
    
    // 商家保证
    UIView *middleContainerView = [[UIView alloc] init];
    middleContainerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:middleContainerView];
    [middleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(describeView.mas_bottom).offset(60);
        make.height.mas_equalTo(120);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView1];
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView2];
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] init];
    imageView4.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView4];
    UIImageView *imageView5 = [[UIImageView alloc] init];
    imageView5.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView5];
    UIImageView *imageView6 = [[UIImageView alloc] init];
    imageView6.backgroundColor = [UIColor colorWithRed:7/255.0 green:85/255.0 blue:34/255.0 alpha:1];
    [middleContainerView addSubview:imageView6];
    
    _imageView1 = imageView1;
    _imageView2 = imageView2;
    _imageView3 = imageView3;
    _imageView4 = imageView4;
    _imageView5 = imageView5;
    _imageView6 = imageView6;
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleContainerView.mas_left).offset(10);
        make.top.mas_equalTo(middleContainerView.mas_top).offset(3);
    }];
    
    [imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleContainerView.mas_left).offset(10);
        make.top.mas_equalTo(imageView1.mas_bottom).offset(10);
        make.bottom.mas_equalTo(middleContainerView.mas_bottom).offset(-3);
        make.height.mas_equalTo(imageView1);
    }];
    
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(middleContainerView.mas_right).offset(-10);
        make.top.mas_equalTo(middleContainerView.mas_top).offset(3);
        make.width.mas_equalTo(imageView1.mas_width);
        make.height.mas_equalTo(imageView1);
    }];
    
    [imageView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(middleContainerView.mas_right).offset(-10);
        make.top.mas_equalTo(imageView3.mas_bottom).offset(10);
        make.bottom.mas_equalTo(middleContainerView.mas_bottom).offset(-3);
        make.height.mas_equalTo(imageView1);
        make.width.mas_equalTo(imageView4.mas_width);
    }];
    
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView1.mas_right).offset(10);
        make.right.mas_equalTo(imageView3.mas_left).offset(-10);
        make.top.mas_equalTo(middleContainerView.mas_top).offset(3);
        make.width.mas_equalTo(imageView1.mas_width);
        make.height.mas_equalTo(imageView1);
    }];
    
    [imageView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView4.mas_right).offset(10);
        make.right.mas_equalTo(imageView6.mas_left).offset(-10);
        make.top.mas_equalTo(imageView2.mas_bottom).offset(10);
        make.bottom.mas_equalTo(middleContainerView.mas_bottom).offset(-3);
        make.height.mas_equalTo(imageView1);
        make.width.mas_equalTo(imageView4.mas_width);
    }];
    
    
    // 相关推荐
    // 分割线
    UIView *remindView = [[UIView alloc] init];
    [scrollView addSubview:remindView];
    [remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.top.mas_equalTo(middleContainerView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"相关推荐";
    remindLabel.font = [UIFont systemFontOfSize:12];
    remindLabel.textColor = [UIColor darkGrayColor];
    [remindView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(remindView.mas_centerX);
        make.centerY.mas_equalTo(remindView.mas_centerY);
    }];
    
    UIView *remindLine = [[UIView alloc] init];
    remindLine.backgroundColor = [UIColor colorWithRed:133/255.0 green:134/255.0 blue:135/255.0 alpha:1];
    [remindView addSubview:remindLine];
    [remindLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(remindLabel.mas_bottom).offset(3);
        make.left.right.mas_equalTo(remindView);
        make.height.mas_equalTo(1);
    }];
    
    // 商品推荐collectionView
    UICollectionViewFlowLayout *productFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    productFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    productFlowLayout.minimumInteritemSpacing = 4;
    productFlowLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);
    productFlowLayout.itemSize = CGSizeMake(kProductCollectionItemWidth, kProductCollectionItemHeight);
    UICollectionView *productCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:productFlowLayout];
    productCollectionView.tag = 2;
    productCollectionView.backgroundColor = [UIColor whiteColor];
    productCollectionView.delegate = self;
    productCollectionView.dataSource = self;
    productCollectionView.scrollEnabled = NO;
    [productCollectionView registerNib:[UINib nibWithNibName:@"FCProductRecommendCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:productRecommendCellID];
    [containerView addSubview:productCollectionView];
    [productCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(containerView);
        make.height.mas_equalTo(kProductCollectionItemHeight * kProductCount / 2 + 64);
        make.top.mas_equalTo(remindView.mas_bottom);
        make.bottom.mas_equalTo(containerView.mas_bottom);
    }];
    _mainCollectionView = productCollectionView;
    
    // 底部悬浮的view
//    FCBottomFunctionView *bottomContainer = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FCBottomFunctionView class]) owner:self options:nil] lastObject];
    UIView *bottomContainer = [[UIView alloc] init];
    bottomContainer.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50);
    bottomContainer.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomContainer];
    
    UIView *homeView = [[UIView alloc] init];
    [bottomContainer addSubview:homeView];
    UIView *starView = [[UIView alloc] init];
    [bottomContainer addSubview:starView];
    UIView *sendView = [[UIView alloc] init];
    [bottomContainer addSubview:sendView];
    UIView *kefuView = [[UIView alloc] init];
    [bottomContainer addSubview:kefuView];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [bottomContainer addSubview:line];
    
    UITapGestureRecognizer *homeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeButtonClick)];
    [homeView addGestureRecognizer:homeTap];
    UITapGestureRecognizer *starTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(starButtonClick)];
    [starView addGestureRecognizer:starTap];
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendButtonClick)];
    [sendView addGestureRecognizer:sendTap];
    UITapGestureRecognizer *kefuTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kefuButtonClick)];
    [kefuView addGestureRecognizer:kefuTap];
    
    [kefuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(bottomContainer);
        
    }];
    [homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomContainer.mas_left).offset(20);
        make.top.bottom.mas_equalTo(bottomContainer);
        make.width.mas_equalTo(50);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomContainer);
        make.right.mas_equalTo(kefuView.mas_left);
        make.width.mas_equalTo(1);
    }];
    [sendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomContainer);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(line.mas_left).offset(-25);
    }];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomContainer);
        make.left.mas_equalTo(homeView.mas_right).offset(25);
        make.right.mas_equalTo(sendView.mas_left).offset(-25);
        make.width.mas_equalTo(50);
    }];
    
    UIImageView *homeImageView = [[UIImageView alloc] init];
    homeImageView.image = [UIImage imageNamed:@"首页"];
    homeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [homeView addSubview:homeImageView];
    UILabel *homeLabel = [[UILabel alloc] init];
    homeLabel.text = @"首页";
    homeLabel.textColor = [UIColor blackColor];
    homeLabel.font = [UIFont systemFontOfSize:12.f];
    [homeView addSubview:homeLabel];
    [homeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(homeView);
        make.left.mas_equalTo(homeView.mas_left).offset(10);
        make.right.mas_equalTo(homeView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(homeView);
        make.centerX.mas_equalTo(homeView.mas_centerX);
    }];
    
    
    UIImageView *starImageView = [[UIImageView alloc] init];
    starImageView.image = [UIImage imageNamed:@"收藏"];
    starImageView.contentMode = UIViewContentModeScaleAspectFit;
    [starView addSubview:starImageView];
    UILabel *starLabel = [[UILabel alloc] init];
    starLabel.text = @"收藏";
    starLabel.textColor = [UIColor blackColor];
    starLabel.font = [UIFont systemFontOfSize:12.f];
    [starView addSubview:starLabel];
    [starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(starView);
        make.left.mas_equalTo(starView.mas_left).offset(10);
        make.right.mas_equalTo(starView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(starView);
        make.centerX.mas_equalTo(starView.mas_centerX);
    }];
    
    
    UIImageView *sendImageView = [[UIImageView alloc] init];
    sendImageView.image = [UIImage imageNamed:@"朋友圈"];
    sendImageView.contentMode = UIViewContentModeScaleAspectFill;
    [sendView addSubview:sendImageView];
    UILabel *sendLabel = [[UILabel alloc] init];
    sendLabel.text = @"朋友圈";
    sendLabel.textColor = [UIColor blackColor];
    sendLabel.font = [UIFont systemFontOfSize:12.f];
    [sendView addSubview:sendLabel];
    [sendImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sendView);
        make.left.mas_equalTo(sendView.mas_left).offset(10);
        make.right.mas_equalTo(sendView.mas_right).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(sendView);
        make.centerX.mas_equalTo(sendView.mas_centerX);
    }];
    
    
    UIImageView *kefuImageView = [[UIImageView alloc] init];
    kefuImageView.image = [UIImage imageNamed:@"客服"];
    kefuImageView.contentMode = UIViewContentModeScaleAspectFit;
    [kefuView addSubview:kefuImageView];
    UILabel *kefuLabel = [[UILabel alloc] init];
    kefuLabel.text = @"联系客服";
    kefuLabel.textColor = [UIColor blackColor];
    kefuLabel.font = [UIFont systemFontOfSize:14.f];
    [kefuView addSubview:kefuLabel];
    [kefuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kefuView.mas_centerY);
        make.left.mas_equalTo(kefuView);
        make.width.mas_equalTo(40);
    }];
    [kefuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(kefuView);
        make.left.mas_equalTo(kefuImageView.mas_right);
    }];
    
}

- (void)playVideo {
    NSLog(@"playVideo");
}

- (void)homeButtonClick {
    NSLog(@"homeButtonClick");
}

- (void)starButtonClick {
    NSLog(@"starButtonClick");
}

- (void)sendButtonClick {
    NSLog(@"sendButtonClick");
}

- (void)kefuButtonClick {
    NSLog(@"kefuButtonClick");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kProductCount;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCProductRecommendCell *productRecommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:productRecommendCellID forIndexPath:indexPath];
    return productRecommendCell;
}

@end
