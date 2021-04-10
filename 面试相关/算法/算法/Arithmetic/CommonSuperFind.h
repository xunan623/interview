//
//  CommonSuperFind.h
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CommonSuperFind : NSObject

// 查找两个视图的共同父视图
- (NSArray<UIView *> *)findCommonSuperView:(UIView *)viewOne other:(UIView *)viewOther;

@end

NS_ASSUME_NONNULL_END
