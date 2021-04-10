//
//  GroupObject.m
//  GCD
//
//  Created by xunan on 2019/8/26.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "GroupObject.h"

@interface GroupObject ()
{
    dispatch_queue_t concurrent_queue;
    NSMutableArray<NSURL *> *arrayURLs;
}

@end

@implementation GroupObject

- (instancetype)init {
    if (self = [super init]) {
        // 创建并发队列
        concurrent_queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
        arrayURLs = [NSMutableArray array];
    }
    return self;
}

- (void)handle {
    // 创建一个group
    dispatch_group_t group = dispatch_group_create();
    
    for (NSURL *url in arrayURLs) {
        // 异步组分派到并发队列当中
        dispatch_group_async(group, concurrent_queue, ^{
            // 根据url去下载图片
            NSLog(@"url is %@", url);
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 当添加到组中的所有任务执行完成后会调用该block
        NSLog(@"所有图片已全部下载完成");
    });
}


@end
