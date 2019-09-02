//
//  BaseObjectA.m
//  设计模式
//
//  Created by xunan on 2019/8/29.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "BaseObjectA.h"

@implementation BaseObjectA

/**
 A1 ---> B1,B2,B3  三种
 A2 ---> B1,B2,B3  三种
 A3 ---> B1,B2,B3  三种
 */

- (void)handle {
    [self.objB fetchData];
}

@end
