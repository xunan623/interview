//
//  IndexTableView.h
//  重用机制
//
//  Created by xunan on 2019/3/7.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IndexTableViewDataSource <NSObject>

// 获取一个TableView索引数据的方法
- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexTableView : UITableView

@property (nonatomic, weak) id<IndexTableViewDataSource> indexDataSource;

@end

NS_ASSUME_NONNULL_END
