//
//  BusinessObject.m
//  责任链
//
//  Created by xunan on 2019/8/29.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "BusinessObject.h"

@interface BusinessObject ()


@end

@implementation BusinessObject

- (void)handle:(ResultBlock)result {
    CompletionBlock completion = ^(BOOL handled) {
        // 当前业务处理掉了,上抛结果
        if (handled) {
            result(self, handled);
        } else {
            // 沿着责任链,指派给下一个业务处理
            if (self.nextBusiness) {
                [self.nextBusiness handle:result];
            } else {
                // 没有业务处理,上抛
                result(nil, NO);
            }
        }
    };
    
    // 当前业务进行处理
    [self handleBusiness:completion];
}

- (void)handleBusiness:(CompletionBlock)completion {
    /**
     业务逻辑处理
     如网络请求,本地照片查询等
     */
}

@end
