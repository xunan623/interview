//
//  CommandManager.m
//  设计模式
//
//  Created by xunan on 2019/8/30.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "CommandManager.h"

@implementation CommandManager

+ (instancetype)sharedInstance {
    
    static CommandManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _arrayCommands = [NSMutableArray array];
    }
    return self;
}

+ (void)executeCommand:(Command *)cmd completion:(CommandCompletionCallBack)completion {
    if (cmd) {
        
        // 如果命令正在执行不做处理,否则添加并执行命令
        if (![self _isExecutingCommand:cmd]) {
            // 添加到命令容器当中
            [[[self sharedInstance] arrayCommands] addObject:cmd];
            // 设置命令执行完成的回调
            cmd.completion = completion;
            // 执行命令
            [cmd execute];
        }
    }
}

+ (void)cancelCommand:(Command *)cmd {
    if (cmd) {
        // 从命令容器当中移除
        [[[self sharedInstance] arrayCommands] removeObject:cmd];
        // 取消命令执行
        [cmd cancel];
    }
}

+ (BOOL)_isExecutingCommand:(Command *)cmd {
    if (cmd) {
        NSArray *cmds = [[self sharedInstance] arrayCommands];
        for (Command *aCmd in cmds) {
            if (cmd == aCmd) {
                return YES;
            }
        }
    }
    return NO;
}

@end
