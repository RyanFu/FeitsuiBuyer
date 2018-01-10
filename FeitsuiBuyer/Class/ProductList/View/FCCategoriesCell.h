//
//  FCCategoriesCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/19.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCProductCategory;
@interface FCCategoriesCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *itemButton;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@property (nonatomic, strong) FCProductCategory *productCategory;

@end
