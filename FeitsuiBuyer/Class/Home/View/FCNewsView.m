//
//  FCNewsView.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/18.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "FCNewsView.h"

@interface FCNewsView()
@property (weak, nonatomic) IBOutlet UILabel *newsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *newsLabel3;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation FCNewsView

- (void)setNews:(NSArray *)newsArray
{
    self.newsLabel1.text = newsArray[0];
    self.newsLabel2.text = newsArray[1];
    self.newsLabel3.text = newsArray[2];
}

- (void)setTitle:(NSString *)title image:(UIImage *)image{
    self.titleNameLabel.text = title;
    self.iconImage.image = image;
}

@end
