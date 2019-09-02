//
//  Command.h
//  设计模式
//
//  Created by xunan on 2019/8/30.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Command;
typedef void(^CommandCompletionCallBack)(Command *cmd);

@interface Command : NSObject

@property (nonatomic, copy) CommandCompletionCallBack completion;

- (void)execute;
- (void)cancel;

- (void)done;

@end

NS_ASSUME_NONNULL_END
