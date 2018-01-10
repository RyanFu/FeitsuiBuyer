//
//  FCProductManagerViewController.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2017/12/24.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCProductManagerViewController.h"

@interface FCProductManagerViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FCProductManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMainView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpMainView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildHeaderSearchView];
}

- (void)buildHeaderSearchView {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 75)];
    [self.view addSubview:self.searchBar];
    self.searchBar.placeholder = @"搜索商品名称";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
