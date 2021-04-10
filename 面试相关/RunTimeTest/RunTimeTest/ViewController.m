//
//  ViewController.m
//  RunTimeTest
//
//  Created by xunan on 2019/10/22.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "ViewController.h"
#import "RuntimeObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RuntimeObject *object = [[RuntimeObject alloc] init];
    [object test];
    [object otherTest];
}

@end
