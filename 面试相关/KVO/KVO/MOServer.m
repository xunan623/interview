//
//  MOServer.m
//  KVO
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MOServer.h"
#import "MObject.h"

@implementation MOServer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(MObject *)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%zd", object.value);
}

@end
