//
//  CoolTarget.h
//  设计模式
//
//  Created by xunan on 2019/8/29.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Target.h"

NS_ASSUME_NONNULL_BEGIN

// 适配对象
@interface CoolTarget : NSObject

/** 被适配对象 */
@property (strong, nonatomic) Target *target;

// 对原有方法包装
- (void)request;

@end

NS_ASSUME_NONNULL_END
