//
//  FCHomePresenter.h
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2018/1/6.
//  Copyright © 2018年 JourneyYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FCHomePresenterDelegate <NSObject>

- (void)pullSlideComplete:(NSMutableArray *)slideArray withError:(NSError *)error;

@end
@interface FCHomePresenter : NSObject

@property (nonatomic, weak) id<FCHomePresenterDelegate> deleagte;

- (void)pullSlides;

@end
