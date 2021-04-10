//
//  ViewController.m
//  事件传递
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    CustomButton *btn = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - Action

- (void)btnClick {
    NSLog(@"点击了有效果了");
}

@end
