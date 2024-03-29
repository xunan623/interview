//
//  MergeSortedList.m
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MergeSortedList.h"

@implementation MergeSortedList

void mergeList(int a[], int aLen, int b[], int bLen, int result[]) {

    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i= 0; // 记录当前存储位置
    
    // 任一数组没有到达边界则进行遍历
    while (p < aLen && q < bLen) {
        
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (a[p] <= b[q]) {
            // 存储a数组中的值
            result[i] = a[p];
            
            // 移动a数组的遍历指针
            p++;
        } else {
            // 存储b数组中的值
            result[i] = b[q];
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    
    while (q < bLen) {
        // 将b数组剩余的部分合并结果到后面
        result[i] = b[q++];
        i++;
    }
}


@end
