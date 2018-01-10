//
//  FCCategoriesListViewController.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/19.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCCategoriesListViewController.h"
#import "FCCategoriesCell.h"
#import "FCCategoriesHeaderView.h"
#import "FCProductCategory.h"
#import <Masonry.h>

// 左边item宽高
static const CGFloat kLeftItemViewWidth = 65.0;
static const CGFloat kLeftItemViewHeight = 40.0;

// 右边item宽高
static const CGFloat kRightItemWidth = 80.0;
static const CGFloat kRightItemHeight = 35.0;

@interface FCCategoriesListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

// 搜索框
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *searchView;

@property (nonatomic, strong) UICollectionView *leftCollectionView;
@property (nonatomic, strong) UICollectionView *rightCollectionView;

@property (nonatomic, strong) FCProductCategory *productCategory;

// 左边item的信息
@property (nonatomic, strong) NSMutableArray *leftDataArray;
// 存储当前选中的item
@property (nonatomic, strong) NSMutableArray *leftSelectedArray;
// 右边item的信息
@property (nonatomic, strong) NSMutableArray *rightDataArray;


@end

@implementation FCCategoriesListViewController

static NSString * const leftCollectionCellID = @"leftCollectionCellID";
static NSString * const rightCollectionCellID = @"rightCollectionCellID";
static NSString * const kHeaderViewID = @"FCCategoriesHeaderView";

- (NSMutableArray *)leftDataArray {
    if (_leftDataArray == nil) {
        NSArray *array = @[@"挂件",@"手镯",@"戒指"];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSString *name in array) {
            FCProductCategory *productCategory = [[FCProductCategory alloc] init];
            productCategory.name = name;
            [tempArray addObject:productCategory];
        }
        _leftDataArray = tempArray;
    }
    return _leftDataArray;
}

- (NSMutableArray *)rightDataArray {
    if (_rightDataArray == nil) {
        NSArray *array = @[@"全部",@"观音",@"佛",@"貔貅",@"如意",@"福瓜",@"平安扣",@"叶子"];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSString *name in array) {
            FCProductCategory *productCategory = [[FCProductCategory alloc] init];
            productCategory.name = name;
            [tempArray addObject: productCategory];
        }
        _rightDataArray = tempArray;
    }
    return _rightDataArray;
}

- (NSMutableArray *)leftSelectedArray {
    if (_leftSelectedArray == nil) {
        _leftSelectedArray = [NSMutableArray array];
    }
    return _leftSelectedArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupAllViews];
}

/**
 * 初始化 Navigation
 */
- (void)setupNavigationBar {
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    searchView.layer.cornerRadius = 5;
    searchView.layer.masksToBounds = YES;
    searchView.backgroundColor = [UIColor whiteColor];
    _searchView = searchView;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    searchBar.delegate = self;
    [searchBar setTintColor:[UIColor whiteColor]];
    [searchView addSubview:searchBar];
    _searchBar = searchBar;
    
    self.navigationItem.titleView = searchView;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:1/255.0 alpha:1];
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 * 初始化所有 view
 */
- (void)setupAllViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCollectionView];
}

- (void)setupCollectionView {
    // 左边的List
    UICollectionViewFlowLayout *leftFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    leftFlowLayout.minimumLineSpacing = 2;
    leftFlowLayout.itemSize = CGSizeMake(kLeftItemViewWidth, kLeftItemViewHeight);
    leftFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *leftCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:leftFlowLayout];
    leftCollectionView.backgroundColor = [UIColor whiteColor];
    leftCollectionView.tag = 1;
    leftCollectionView.delegate = self;
    leftCollectionView.dataSource = self;
    leftCollectionView.alwaysBounceVertical = YES;
    [leftCollectionView registerNib:[UINib nibWithNibName:@"FCCategoriesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:leftCollectionCellID];
    [self.view addSubview:leftCollectionView];
    [leftCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(10);
        make.width.mas_equalTo(kLeftItemViewWidth);
    }];
    
    // 右边的List
    UICollectionViewFlowLayout *rightFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    rightFlowLayout.minimumInteritemSpacing = 10;
    rightFlowLayout.minimumLineSpacing = 5;
    rightFlowLayout.itemSize = CGSizeMake(kRightItemWidth, kRightItemHeight);
    rightFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    rightFlowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 60);
    
    UICollectionView *rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:rightFlowLayout];
    rightCollectionView.backgroundColor = [UIColor whiteColor];
    rightCollectionView.tag = 2;
    rightCollectionView.delegate = self;
    rightCollectionView.dataSource = self;
    rightCollectionView.alwaysBounceVertical = YES;
    rightCollectionView.showsVerticalScrollIndicator = NO;
    rightCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    [rightCollectionView registerNib:[UINib nibWithNibName:@"FCCategoriesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:rightCollectionCellID];
    [rightCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FCCategoriesHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID];
    
    [self.view addSubview:rightCollectionView];
    [rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftCollectionView.mas_right).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - UICollectionView

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        FCCategoriesHeaderView *headeView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID forIndexPath:indexPath];
        return headeView;
    }
    else
        return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView.tag == 1) {
        return 1;
    }
    else
        return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        return self.leftDataArray.count;
        
    }
    return self.rightDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCCategoriesCell *cell;
    if (collectionView.tag == 1) {
        FCProductCategory *productCategory = _leftDataArray[indexPath.item];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:leftCollectionCellID forIndexPath:indexPath];
        cell.itemLabel.text = productCategory.name;
        cell.itemLabel.textColor = [UIColor blackColor];
        cell.itemLabel.font = [UIFont systemFontOfSize:12];
        if (self.leftSelectedArray.count == 0) {
            if (indexPath.row == 0) {
                cell.backgroundColor = [UIColor whiteColor];
            } else {
                cell.backgroundColor = [UIColor colorWithRed:229/255.0 green:230/255.0 blue:231/255.0 alpha:1];
            }
        } else {
            if ([_leftSelectedArray containsObject:_leftDataArray[indexPath.item]]) {
                cell.backgroundColor = [UIColor whiteColor];
            } else {
                cell.backgroundColor = [UIColor colorWithRed:229/255.0 green:230/255.0 blue:231/255.0 alpha:1];
            }
        }
       
    }
    else {
        FCProductCategory *productCategory = _rightDataArray[indexPath.item];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:rightCollectionCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:236/255.0 alpha:1];
        cell.itemLabel.text = productCategory.name;
        cell.itemLabel.textColor = [UIColor grayColor];
        cell.itemLabel.font = [UIFont systemFontOfSize:12];
        cell.itemButton.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:236/255.0 alpha:1];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FCCategoriesCell *cell = (FCCategoriesCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (collectionView.tag == 1) {
        self.leftSelectedArray = [NSMutableArray arrayWithObject:_leftDataArray[indexPath.item]];
        [collectionView reloadData];
    }
    if (collectionView.tag == 2) {
        NSLog(@"%@",cell.itemLabel.text);
    }
}

@end
