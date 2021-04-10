//
//  RuntimeObject.m
//  RunTimeTest
//
//  Created by xunan on 2019/10/22.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>

@implementation RuntimeObject

+ (void)load {
    Method test = class_getInstanceMethod(self, @selector(test));
    Method otherTest = class_getInstanceMethod(self, @selector(otherTest));
    // 交换
    method_exchangeImplementations(test, otherTest);
}

void testImp (void)
{
    NSLog(@"test invoke");
}

- (void)test {
    NSLog(@"test");
}

- (void)otherTest {
    [self otherTest];
    NSLog(@"otherTest");
}

#pragma mark - 消息转发流程第1个方法

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    // 如果是test方法 打印日志
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod:");
        
        // 动态添加test方法的实现
        class_addMethod(self, @selector(test), testImp, "v@:");
        
        return NO;
    }
    else {
        // 返回父类的默认调用
        return [super resolveInstanceMethod:sel];
    }
}

#pragma mark - 消息转发流程第2个方法

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"forwardingTargetForSelector:");
    return nil;
}

#pragma mark - 消息转发流程第3个方法

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector:");
        // v 代表返回值void类型 @代表第一个参数类型时id 即self :代表第二个参数是SEL类型的 代表@selector(test)
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    else {
        return [super methodSignatureForSelector:aSelector];
    }
}

#pragma mark - 消息转发流程第4个方法

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation:");

}

@end
