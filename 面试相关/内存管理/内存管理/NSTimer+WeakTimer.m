//
//  NSTimer+WeakTimer.m
//  内存管理
//
//  Created by xunan on 2019/11/5.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "NSTimer+WeakTimer.h"

@interface TimerWeakObject : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer {
    
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            [self.target performSelector:self.selector withObject:timer.userInfo];
        }
    }
    else {
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats {
    
    TimerWeakObject *object = [[TimerWeakObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    object.timer = [NSTimer scheduledWeakTimerWithTimeInterval:interval target:object selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    return object.timer;
}


@end
