//
//  BaseObjectA.h
//  设计模式
//
//  Created by xunan on 2019/8/29.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObjectB.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseObjectA : NSObject

/** 桥接模式的核心实现 */
@property (strong, nonatomic) BaseObjectB *objB;

// 获取数据
- (void)handle;

@end

NS_ASSUME_NONNULL_END
