//
//  NSTimer+WeakTimer.h
//  内存管理
//
//  Created by xunan on 2019/11/5.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats;

@end

NS_ASSUME_NONNULL_END
