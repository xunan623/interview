//
//  CustomButton.m
//  事件传递
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.isUserInteractionEnabled ||
        [self isHidden] ||
        self.alpha <= 0.01) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) {
        // 遍历当前对象的子视图
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 坐标转换
            CGPoint vonvertPoint = [self convertPoint:point toView:obj];
            // 调用子视图的hitTest方法
            hit = [obj hitTest:vonvertPoint withEvent:event];
            // 如果找到了接受对象的视图,停止遍历
            if (hit) {
                *stop = YES;
            }
        }];
        
        if (hit) {
            return hit;
        } else {
            return self;
        }
    } else {
        return nil;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGFloat x1 = point.x;
    CGFloat y1 = point.y;
    
    CGFloat x2 = self.frame.size.width / 2;
    CGFloat y2 = self.frame.size.height / 2;
    
    double dis = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
    
    // 以当前控件为直径的控件内,则显示区域
    if (dis < self.frame.size.width / 2) {
        return YES;
    } else {
        return NO;
    }
}

@end
