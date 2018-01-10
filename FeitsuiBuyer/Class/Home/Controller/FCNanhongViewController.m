//
//  FCNanhongViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/19.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCNanhongViewController.h"
#import "JNBannerView.h"
#import "FCProductRecommendCell.h"
#import "FCPinLeiCell.h"
#import "FCNewsView.h"
#import <Masonry.h>

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// banner高度
static const CGFloat kBannerHeight = 192.0;
// 广告高度
static const CGFloat kAdvertisementHeight = 80.0;
static const CGFloat kAdvertisementMargin = 2.0;
// 品类collectionView
static const CGFloat kPinleiCollectionItemWidth = 50.0;
static const CGFloat kPinleiCollectionItemHeight = 80.0;
// 商品推荐collectionView
static const CGFloat kProductCollectionItemWidth = 180.0;
static const CGFloat kProductCollectionItemHeight = 240.0;

static const NSInteger pinleiCount = 6;
static const NSInteger productCount = 10;

@interface FCNanhongViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JNBannerViewDelegate, JNBannerViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UIScrollView *vScrollView;
@property (nonatomic, strong) UIView *contentView;
// banner
@property (nonatomic, strong) JNBannerView *banner;
// 新闻链接
@property (nonatomic, strong) FCNewsView *leftNewsView;
@property (nonatomic, strong) FCNewsView *rightNewsView;
// 推荐文字
@property (nonatomic, strong) UIView *remindView;
@property (nonatomic, strong) UILabel *remindLabel;
// 品类collectionView
@property (nonatomic, strong) UICollectionView *pinleiCollectionView;
// 商品推荐collectionView
@property (nonatomic, strong) UICollectionView *collectionView;



// 数据及其他
@property (nonatomic, strong) NSArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *adImageViewArray;
@property (nonatomic, strong) NSArray *adArray;
@property (nonatomic, strong) NSArray *pinleiArray;

@end

@implementation FCNanhongViewController

static NSString * const productRecommendCellID = @"productRecommendCellID";
static NSString * const pinleiCellID = @"pinleiCellID";



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAllViews];
}



/**
 * 初始化所有View
 */
- (void)setupAllViews {
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentInset = UIEdgeInsetsMake(35, 0, 49 + 35, 0);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _vScrollView = scrollView;
    
    
    // containerView
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    _contentView = contentView;
    
    
    // bannerView
    JNBannerView *banner = [[JNBannerView alloc] init];
    banner = [[JNBannerView alloc] init];
    banner.dataSource = self;
    banner.delegate = self;
    banner.shouldLoop = YES;
    banner.autoScroll = YES;
    [scrollView addSubview:banner];
    
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.mas_equalTo(contentView);
        make.height.mas_equalTo(kBannerHeight);
    }];
    _banner = banner;
    
    
    
    // 宣传广告(支持多条广告)
    UIImageView *lastImageView = [[UIImageView alloc] init];
    for (NSString *adImageName in self.adArray) {
        UIImageView *adImageView = [[UIImageView alloc] init];
        adImageView.image = [UIImage imageNamed:adImageName];
        [scrollView addSubview:adImageView];
        
        [adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([adImageName isEqualToString:self.adArray[0]]) {
                make.top.mas_equalTo(banner.mas_bottom).offset(kAdvertisementMargin);
            }
            else {
                make.top.mas_equalTo(lastImageView.mas_bottom).offset(kAdvertisementMargin);
            }
            make.left.right.mas_equalTo(scrollView);
            make.height.mas_equalTo(kAdvertisementHeight);
        }];
        lastImageView = adImageView;
        [_adImageViewArray addObject:adImageView];
    }
    
    
    // 品类collectionView
    UICollectionViewFlowLayout *pinleiFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    pinleiFlowLayout.minimumInteritemSpacing = 4;
    pinleiFlowLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 4);
    pinleiFlowLayout.itemSize = CGSizeMake(kPinleiCollectionItemWidth, kPinleiCollectionItemHeight);
    pinleiFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *pinleiCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:pinleiFlowLayout];
    pinleiCollectionView.backgroundColor = [UIColor whiteColor];
    pinleiCollectionView.tag = 1;
    pinleiCollectionView.delegate = self;
    pinleiCollectionView.dataSource = self;
    pinleiCollectionView.scrollEnabled = NO;
    [pinleiCollectionView registerNib:[UINib nibWithNibName:@"FCPinLeiCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:pinleiCellID];
    [scrollView addSubview:pinleiCollectionView];
    
    [pinleiCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.mas_equalTo(lastImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(kPinleiCollectionItemHeight);
    }];
    
    
    // 新闻链接View
    UIView *newsContentView = [[UIView alloc] init];
    newsContentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:newsContentView];
    [newsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.mas_equalTo(pinleiCollectionView.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    
    UIView *newsHLine = [[UIView alloc] init];
    newsHLine.backgroundColor = [UIColor colorWithRed:133/255.0 green:134/255.0 blue:135/255.0 alpha:1];
    [newsContentView addSubview:newsHLine];
    [newsHLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(newsContentView.mas_top).offset(3);
        make.height.mas_equalTo(0.6);
        make.right.left.mas_equalTo(newsContentView);
    }];
    
    FCNewsView *leftNewsView = [[[NSBundle mainBundle] loadNibNamed:@"FCNewsView" owner:self options:nil] lastObject];
    [newsContentView addSubview:leftNewsView];
    [leftNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(newsContentView.mas_left);
        make.top.mas_equalTo(newsHLine).offset(1);
        make.bottom.mas_equalTo(newsContentView);
        make.width.mas_equalTo(newsContentView.mas_width).multipliedBy(0.5).offset(-2);
        
    }];
    _leftNewsView = leftNewsView;
    
    UIView *newsVLine = [[UIView alloc] init];
    newsVLine.backgroundColor = [UIColor colorWithRed:133/255.0 green:134/255.0 blue:135/255.0 alpha:1];
    [newsContentView addSubview:newsVLine];
    [newsVLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftNewsView.mas_right);
        make.height.mas_equalTo(leftNewsView.mas_height).multipliedBy(0.6);
        make.centerY.mas_equalTo(newsContentView.mas_centerY);
        make.width.mas_equalTo(1.5);
    }];
    
    FCNewsView *rightNewsView = [[[NSBundle mainBundle] loadNibNamed:@"FCNewsView" owner:self options:nil] lastObject];
    [newsContentView addSubview:rightNewsView];
    [rightNewsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(newsContentView.mas_right);
        make.top.mas_equalTo(newsHLine).offset(1);
        make.bottom.mas_equalTo(newsContentView);
        make.width.mas_equalTo(newsContentView.mas_width).multipliedBy(0.5);
    }];
    _rightNewsView = rightNewsView;
    
    
    
    // remindView
    UIView *remindView = [[UIView alloc] init];
    [scrollView addSubview:remindView];
    [remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.mas_equalTo(newsContentView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    _remindView = remindView;
    
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"最新推荐  仅此一件";
    remindLabel.font = [UIFont systemFontOfSize:12];
    remindLabel.textColor = [UIColor darkGrayColor];
    [remindView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(remindView.mas_centerX);
        make.centerY.mas_equalTo(remindView.mas_centerY);
    }];
    _remindLabel = remindLabel;
    
    UIView *remindLine = [[UIView alloc] init];
    remindLine.backgroundColor = [UIColor colorWithRed:133/255.0 green:134/255.0 blue:135/255.0 alpha:1];
    [remindView addSubview:remindLine];
    [remindLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(remindLabel.mas_bottom).offset(3);
        make.left.right.mas_equalTo(remindView);
        make.height.mas_equalTo(0.6);
    }];
    
    
    
    // 商品推荐collectionView
    UICollectionViewFlowLayout *productFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    productFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    productFlowLayout.minimumInteritemSpacing = 4;
    productFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    productFlowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-40)*0.5, kProductCollectionItemHeight);
    UICollectionView *productCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, kScreenHeight) collectionViewLayout:productFlowLayout];
    productCollectionView.tag = 2;
    productCollectionView.backgroundColor = [UIColor whiteColor];
    productCollectionView.delegate = self;
    productCollectionView.dataSource = self;
    productCollectionView.scrollEnabled = NO;
    [productCollectionView registerNib:[UINib nibWithNibName:@"FCProductRecommendCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:productRecommendCellID];
    [scrollView addSubview:productCollectionView];
    
    [productCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.mas_equalTo(remindView.mas_bottom);
        make.bottom.mas_equalTo(contentView);
        make.height.mas_equalTo(kProductCollectionItemHeight * productCount / 2 + 64);
    }];
    _collectionView = productCollectionView;
}


#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        return pinleiCount;
    }
    else
        return productCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 1) {
        FCPinLeiCell *pinleiCell = [collectionView dequeueReusableCellWithReuseIdentifier:pinleiCellID forIndexPath:indexPath];
        pinleiCell.nameLabel.text = self.pinleiArray[indexPath.row];
        return pinleiCell;
    }
    
    else if (collectionView.tag == 2) {
        FCProductRecommendCell *productRecommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:productRecommendCellID forIndexPath:indexPath];
        
        return productRecommendCell;
    }
    
    else {
        UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
        return cell;
    }
}


#pragma mark - JNBannerView
- (NSInteger)numberOfItemsInBanner:(JNBannerView *)banner {
    return self.bannerArray.count;
}

- (UIView *)banner:(JNBannerView *)banner viewForItemAtIndex:(NSInteger)index {
    // 取出数据
    NSString *imageName = self.bannerArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

// 在这里实现banner点击事件的处理
- (void)banner:(JNBannerView *)banner didSelectItemAtIndex:(NSInteger)index {
    
}

- (void)banner:(JNBannerView *)banner didScrollToItemAtIndex:(NSInteger)index {
    
}

#pragma mark - getter/setter
- (NSArray *)bannerArray {
    if (_bannerArray == nil) {
        _bannerArray = @[@"banner1.jpg", @"banner2.jpg", @"banner3.jpg"];
    }
    return _bannerArray;
}

- (NSArray *)adArray {
    if (_adArray == nil) {
        _adArray = @[@"banner1.jpg", @"banner2.jpg"];
    }
    return _adArray;
}

- (NSArray *)pinleiArray {
    if (_pinleiArray == nil) {
        _pinleiArray = @[@"手镯",@"挂件",@"戒指",@"珠串",@"项链",@"更多"];
    }
    return _pinleiArray;
}

- (NSMutableArray *)adImageViewArray {
    if (_adImageViewArray == nil) {
        _adImageViewArray = [NSMutableArray array];
    }
    return _adImageViewArray;
}

@end
