//
//  MCBlock.m
//  Block截获变量
//
//  Created by xunan on 2019/8/19.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MCBlock.h"


@interface MCBlock ()

@end

@implementation MCBlock

// 全局变量
int global_var = 4;
// 静态全局变量
static int static_global_var = 5;

- (void)method {
    // 基本数据类型的局部变量
    int var = 1;
    // 对象类型的局部变量
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_obj = nil;
    
    // 局部静态变量
    static int static_var = 3;
    
    void(^Block)(void) = ^{
        NSLog(@"局部变量<基本数据类型> var %d", var);
        NSLog(@"局部变量<__unsafe_unretained 对象类型> var %@", unsafe_obj);
        NSLog(@"局部变量<__strong 对象类型> var %@", strong_obj);

        NSLog(@"静态变量 %d", static_var);

        NSLog(@"全局变量 %d", global_var);
        NSLog(@"静态全局变量 %d", static_global_var);
        NSLog(@"==========================================");

    };
    Block();
    
    // 局部变量基本数据类型
    int multiplier = 6;
    int (^NumBlock)(int) = ^int(int num) {
        return num * multiplier;
    };
    multiplier = 4;
    NSLog(@"result is %d", NumBlock(2));
    
    
    // 局部静态变量 取指针地址
    static int static_multiplier = 6;
    int (^StaticNumBlock)(int) = ^int(int num) {
        return num * static_multiplier;
    };
    static_multiplier = 4;
    NSLog(@"result is %d", StaticNumBlock(2));
    
    
    __block int blockMultiplier = 6;
    int(^blockMulitiplierBlock)(int) = ^int(int num) {
        return multiplier * num;
    };
    blockMultiplier = 4;
    NSLog(@"result is %d", blockMulitiplierBlock(2));
    
    
    __block int multiplierFor = 10;

    
    

}

@end
