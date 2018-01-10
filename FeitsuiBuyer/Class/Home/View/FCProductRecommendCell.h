//
//  FCProductRecommendCell.h
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/13.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCHomeProductModel;
@interface FCProductRecommendCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)reloadViewWithProductModel:(FCHomeProductModel *)model;

@end
