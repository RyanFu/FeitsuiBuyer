//
//  FCProductRecommendCell.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/13.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCProductRecommendCell.h"
#import "FCHomeProductModel.h"

@interface FCProductRecommendCell ()

@property (weak, nonatomic) IBOutlet UIImageView *productImage;


@property (weak, nonatomic) IBOutlet UILabel *productName;



@end

@implementation FCProductRecommendCell

- (void)reloadViewWithProductModel:(FCHomeProductModel *)model {
    self.productImage.image = [UIImage imageNamed:model.imageName];
    self.productName.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
