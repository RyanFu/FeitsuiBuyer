//
//  FCHomePresenter.m
//  FeitsuiBuyer
//
//  Created by JourneyYoung on 2018/1/6.
//  Copyright © 2018年 JourneyYoung. All rights reserved.
//

#import "FCHomePresenter.h"
#import "FCNetworkingManager.h"
#import "JSONModel.h"
#import "FCSlideModel.h"

@interface FCHomePresenter ()

@property (nonatomic, strong) NSMutableArray *slidesArray;

@end

@implementation FCHomePresenter

- (void)pullSlides{
    __weak typeof(self) weakSelf = self;
    [FCNetworkingManager getWithURLString:GET_ALL_SLIDES parameters:nil success:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        if([responseObject[@"code"]isEqualToString:@"200"])
        {
            NSArray *arr = responseObject[@"data"];
            NSArray *dataArray = [FCSlideModel arrayOfModelsFromDictionaries:arr error:nil];
            weakSelf.slidesArray = [NSMutableArray arrayWithArray:dataArray];
            [weakSelf slideDelegate:nil];
        }
    } failure:^(NSError *error) {
        [weakSelf slideDelegate:error];
    }];
}

- (void)slideDelegate:(NSError *)error{
    if([self.deleagte respondsToSelector:@selector(pullSlideComplete:withError:)]){
        if(self.slidesArray.count == 0){
            FCSlideModel *model = [[FCSlideModel alloc]init];
            model.pic = @"slide/2017-12-19/tccsb64IwExYYNioUoz3JSJBFDssbghuBLJX38Bx.jpeg";
            self.slidesArray = [NSMutableArray arrayWithObjects:model, nil];
        }
        if(!error){
            
            [self.deleagte pullSlideComplete:self.slidesArray withError:nil];
        }
        else{
            [self.deleagte pullSlideComplete:self.slidesArray withError:error];
        }
    }
}

@end
