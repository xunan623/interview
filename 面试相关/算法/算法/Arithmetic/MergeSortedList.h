//
//  MergeSortedList.h
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//  有序数组合并

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MergeSortedList : NSObject

// 将有序数组a和b的值合并到一个数组result当中,且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[]);

@end

NS_ASSUME_NONNULL_END
