//
//  Phone.m
//  test
//
//  Created by xunan on 2021/3/22.
//

#import "Phone.h"

@implementation Phone

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }
    return self;
}

@end
