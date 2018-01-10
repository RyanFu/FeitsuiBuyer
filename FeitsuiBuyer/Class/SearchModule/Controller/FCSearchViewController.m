//
//  FCSearchViewController.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/20.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCSearchViewController.h"
#import "FCSearchSelectTableViewCell.h"
#import "FCSearchInfoCollectionViewCell.h"
#import "FCSearchSelectModel.h"
#import "FCSearchInfoModel.h"
#import "FCNetworkingManager.h"
#import "UIColor+JYColor.h"

//static NSInteger kScreenWidth = [UIScreen mainScreen].bounds.size.width;
//static NSInteger kScreenHeight = [UIScreen mainScreen].bounds.size.height;
static NSString *kTableViewID = @"FCSearchSelectTableViewCell";
static NSString *kCollectionViewID = @"FCSearchInfoCollectionViewCell";
static NSString *kCollectionHeaderViewID = @"CollectionHeaderView";

@interface FCSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *selectTableView;

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) NSMutableArray *selectTableDataSource;

@property (nonatomic, strong) NSMutableArray *mainCollectionDataSource;

@property (nonatomic, strong) FCSearchSelectTableViewCell *lastSelectTableViewCell;

@property (nonatomic, strong) FCSearchInfoCollectionViewCell *lastSelecCollectionCell;

@property (nonatomic, assign) NSInteger currentTableIndex;

@property (nonatomic, assign) NSInteger currentCollectionIndex;

@end

@implementation FCSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self checkDate];
    self.currentTableIndex = 0;
    self.currentCollectionIndex = 0;
    [self buildSelectTableView];
    [self buidMainCollectionView];
    [self getGoods];
    // Do any additional setup after loading the view.
}

- (void)getGoods{
    [FCNetworkingManager getWithURLString:GET_ALL_CATS parameters:nil success:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *arr = [FCSearchSelectModel arrayOfModelsFromDictionaries:responseObject[@"data"] error:nil];
        if(arr.count>0){
            [self.selectTableDataSource addObjectsFromArray:arr];
            
            [self.selectTableView reloadData];
            [self.mainCollectionView reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectTableDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FCSearchSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewID];
    if(!cell){
        cell = [[FCSearchSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == self.currentTableIndex){
        [cell setUpViewBackgroundColor:[UIColor whiteColor]];
    }
    [cell reloadViewWithData:self.selectTableDataSource[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentTableIndex = indexPath.row;
    if(!self.lastSelectTableViewCell){
        FCSearchSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0  ]];
        [cell setUpViewBackgroundColor:[UIColor colorWithHexString:@"#E1E2E3"]];
    }
    else{
        [self.lastSelectTableViewCell setUpViewBackgroundColor:[UIColor colorWithHexString:@"#E1E2E3"]];
    }
    FCSearchSelectTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setUpViewBackgroundColor:[UIColor whiteColor]];
    self.lastSelectTableViewCell = cell;
    
    [self.mainCollectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.selectTableDataSource.count==0){
        return 0;
    }
    FCSearchSelectModel *model = self.selectTableDataSource[self.currentTableIndex];
    return model.type.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FCSearchSelectModel *model = self.selectTableDataSource[self.currentTableIndex];
    NSArray *arr = [FCSearchInfoModel arrayOfModelsFromDictionaries:model.type error:nil];
    FCSearchInfoModel *infoModel = arr[section];
    NSString *str = infoModel.type_val;
    NSArray *finarr = [str componentsSeparatedByString:@","];
    return finarr.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderViewID forIndexPath:indexPath];
    
    FCSearchSelectModel *model = self.selectTableDataSource[self.currentTableIndex];
    NSArray *arr = [FCSearchInfoModel arrayOfModelsFromDictionaries:model.type error:nil];
    FCSearchInfoModel *infoModel = arr[indexPath.section];
    NSString *str = infoModel.type_val;
    NSArray *finarr = [str componentsSeparatedByString:@","];
    NSString *finstr = finarr[indexPath.row];
    
    UILabel *label;
    if(!header.subviews.count){
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 29, header.bounds.size.width-20, 2)];
        line.backgroundColor = [UIColor colorWithHexString:@"#E7E8E9"];
        [header addSubview:line];
        label = [[UILabel alloc]initWithFrame:CGRectMake(header.bounds.size.width*0.5-35, 0, 70, 60)];
        label.font = [UIFont systemFontOfSize:12.f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.text = finstr;
        [header addSubview:label];
    }
    else{
        for(UIView *view in header.subviews){
            if([view isKindOfClass:[UILabel class]]){
                UILabel *label = (UILabel *)view;
                label.text = finstr;
            }
        }
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FCSearchInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewID forIndexPath:indexPath];
    FCSearchSelectModel *model = self.selectTableDataSource[self.currentTableIndex];
    NSArray *arr = [FCSearchInfoModel arrayOfModelsFromDictionaries:model.type error:nil];
    FCSearchInfoModel *infoModel = arr[indexPath.section];
    NSString *str = infoModel.type_val;
    NSArray *finarr = [str componentsSeparatedByString:@","];
    NSString *finstr = finarr[indexPath.row];
    
    [cell loadViewWithInfo:finstr];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.lastSelecCollectionCell.contentView.backgroundColor = [UIColor lightGrayColor];
    FCSearchInfoCollectionViewCell *cell = (FCSearchInfoCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#343435"];
    self.lastSelecCollectionCell = cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buidMainCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置每个item的大小，
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 95 - 40)/3, 40);
    // 设置列的最小间距
    flowLayout.minimumInteritemSpacing = 20;
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 10;
    // 设置布局的内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置头饰图大小
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 95, 60);


    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(85, 30, [UIScreen mainScreen].bounds.size.width - 95, [UIScreen mainScreen].bounds.size.height-30) collectionViewLayout:flowLayout];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    [self.mainCollectionView registerClass:[FCSearchInfoCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewID];
    [self.mainCollectionView registerClass:[UICollectionReusableView class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderViewID];
    [self.view addSubview:self.mainCollectionView];
}

- (void)buildSelectTableView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 65, [UIScreen mainScreen].bounds.size.height-30)];
    self.selectTableView.delegate = self;
    self.selectTableView.dataSource = self;
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.selectTableView];
}

- (NSMutableArray *)selectTableDataSource{
    if(!_selectTableDataSource){
        _selectTableDataSource = [NSMutableArray array];
    }
    return _selectTableDataSource;
}

- (NSMutableArray *)mainCollectionDataSource {
    if(!_mainCollectionDataSource){
        _mainCollectionDataSource = [NSMutableArray array];
    }
    return _mainCollectionDataSource;
}

@end
