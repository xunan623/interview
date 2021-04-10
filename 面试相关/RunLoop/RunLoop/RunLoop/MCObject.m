//
//  MCObject.m
//  RunLoop
//
//  Created by xunan on 2019/8/26.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MCObject.h"

@interface MCObject ()



@end

@implementation MCObject

static NSThread *thread = nil;
// 标记是否要继续事件循环
static BOOL runAlways = YES;

+ (NSThread *)threadForDispatch {
    if (thread == nil) {
        @synchronized (self) {
            if (thread == nil) {
                // 线程的创建
                thread = [[NSThread alloc] initWithTarget:self selector:@selector(runRequest) object:nil];
                [thread setName:@"com.imooc.thread"];
                // 启动
                [thread start];
            }
        }
    }
    return thread;
}

+ (void)runRequest {
    // 创建一个Source
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    // 创建Runloop, 同时想Runloop的DefalutMode下面添加Source
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    // 如果可以运行
    while (runAlways) {
        @autoreleasepool {
            // 令当前RunLoop运行的DefaultMode下面  1.0e10表示很久的时间
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
        }
    }
    
    // 某一时机 静态变量runAlways = NO 时, 可以保证跳出RunLoop,线程退出
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

@end
