//
//  MedianFind.m
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "MedianFind.h"

@implementation MedianFind

int findMedian(int a[], int aLen) {

    int low = 0;
    int high = aLen - 1;
    
    int mid = (aLen - 1)/2;
    // 快排
    int div = PartSort(a, low, high);
 
    while (div != mid) {
        if (mid < div) {
            // 左半区间栈
            div = PartSort(a, low, div -1);
        }
        else {
            // 右半区间栈
            div = PartSort(a, div + 1, high);
        }
    }
    // 找到了
    return a[mid];
}

int PartSort(int a[], int start, int end) {
    
    int low = start;
    int high = end;
    
    // 选取关键字
    int key = a[end];
    
    while (low < high) {
        
        // 左边找比key大的值
        while(low < high && a[low] <= key) {
            ++low;
        }
        
        // 右边找比key小的值
        while (low < high && a[high] >= key) {
            --high;
        }
        
        if (low < high) {
            // 找到之后交换左右的值
            int temp = a[low];
            a[low] = a[high];
            a[high] = temp;
        }
    }
    
    int temp = a[high];
    a[high] = a[end];
    a[end] = temp;
    
    return low;
}

@end
