//
//  MObject.m
//  KVO
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MObject.h"

@implementation MObject

- (instancetype)init {
    if (self = [super init]) {
        _value = 0;
    }
    return self;
}



- (void)increase {
    _value += 1;
}

@end
