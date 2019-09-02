//
//  Mooc.m
//  设计模式
//
//  Created by xunan on 2019/8/29.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "Mooc.h"

@implementation Mooc

+ (id)sharedInstance {
    // 静态局部变量
    static Mooc *instance = nil;
    
    // 通过dispatch_once方式 确保instance在多线程环境下只被创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

// 重写方法[必不可少]
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
