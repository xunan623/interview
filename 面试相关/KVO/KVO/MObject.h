//
//  MObject.h
//  KVO
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MObject : NSObject

@property (nonatomic, assign) NSInteger value;

- (void)increase;

@end

NS_ASSUME_NONNULL_END
