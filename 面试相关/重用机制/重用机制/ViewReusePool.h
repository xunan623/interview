//
//  ViewReusePool.h
//  重用机制
//
//  Created by xunan on 2019/3/7.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 实现重用机制类
@interface ViewReusePool : NSObject

// 从重用池中取出可以复用的View
- (UIView *)dequeueResuableView;

// 向重用池中添加一个View
- (void)addUsingView:(UIView *)view;

// 重置方法,将当前使用的视图移动到可重用队列中
- (void)reset;
@end

NS_ASSUME_NONNULL_END
