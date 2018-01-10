//
//  UIScrollView+Extension.m
//  FeitsuiBuyer
//
//  Created by Yukino on 2017/12/23.
//  Copyright © 2017年 JourneyYoung. All rights reserved.
//

#import "UIScrollView+Extension.h"

@implementation UIScrollView (Extension)


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder]touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder]touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder]touchesEnded:touches withEvent:event];
}

@end
