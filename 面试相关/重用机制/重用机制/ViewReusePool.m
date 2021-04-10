//
//  ViewReusePool.m
//  重用机制
//
//  Created by xunan on 2019/3/7.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()
// 等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 正在使用的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation ViewReusePool

- (instancetype)init {
    if (self = [super init]) {
        _waitUsedQueue = [[NSMutableSet alloc] init];
        _usingQueue = [[NSMutableSet alloc] init];
    }
    return self;
}


// 从重用池中取出可以复用的View
- (UIView *)dequeueResuableView {
    UIView *currentView = [self.usingQueue anyObject];
    if (currentView == nil) {
        return nil;
    } else {
        // 队列的移除
        [_waitUsedQueue removeObject:currentView];
        [_usingQueue addObject:currentView];
        return currentView;
    }
    return nil;
}

// 向重用池中添加一个View
- (void)addUsingView:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    // 添加到使用中的队列
    [_usingQueue addObject:view];
}

// 重置方法,将当前使用的视图移动到可重用队列中
- (void)reset {
    UIView *currentView = nil;
    while (currentView == [_usingQueue anyObject]) {
        [_usingQueue removeObject:currentView];
        [_waitUsedQueue addObject:currentView];
    }
    
}


@end
