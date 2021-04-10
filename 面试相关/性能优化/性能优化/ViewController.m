//
//  ViewController.m
//  性能优化
//
//  Created by xunan on 2019/11/27.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// 取代__attribute__((constructor)),C++静态构造器,ObjC的+load
+ (void)initialize { // 多次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ // 一次
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


@end
