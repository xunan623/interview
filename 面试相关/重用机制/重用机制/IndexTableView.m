//
//  IndexTableView.m
//  重用机制
//
//  Created by xunan on 2019/3/7.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "IndexTableView.h"
#import "ViewReusePool.h"

@interface IndexTableView () {
    UIView *containerView;
    ViewReusePool *reusePool;
}

@end

@implementation IndexTableView

- (void)reloadData {
    [super reloadData];
 
    if (containerView == nil) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        // 避免索引条随着TableView滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (reusePool == nil) {
        reusePool = [[ViewReusePool alloc] init];
    }
    
    [reusePool reset];
    
    [self reloadIndexBar];
}

- (void)reloadIndexBar {
    
//    NSArray<NSString *> *arrayTitles = nil;
//    if ([self.indexDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
//        arrayTitles = [self.indexDataSource indexTitlesForIndexTableView:self];
//    }
//    
//    if (!arrayTitles || arrayTitles.count == 0) {
//        [containerView setHidden:YES];
//        return;
//    }
//    
//    NSUInteger count = arrayTitles.count;
//    CGFloat btnWidth = 60;
//    CGFloat btnHeight = self.frame.size.height/count;
//    for (NSInteger i = 0; i < arrayTitles.count; i++) {
//        
//        // 从重用池中取出一个Btn
//        UIButton *btn = (UIButton *)
//    }
}

@end
