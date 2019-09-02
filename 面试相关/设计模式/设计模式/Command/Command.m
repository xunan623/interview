//
//  Command.m
//  设计模式
//
//  Created by xunan on 2019/8/30.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "Command.h"
#import "CommandManager.h"

@implementation Command

- (void)execute {
    
    // override to subclass
    [self done];
}

- (void)cancel {
    
    self.completion = nil;
}

- (void)done {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.completion) {
            self.completion(self);
        }
        
        // 释放
        self.completion = nil;
        
        [[CommandManager sharedInstance].arrayCommands removeObject:self];
    });
}

@end
