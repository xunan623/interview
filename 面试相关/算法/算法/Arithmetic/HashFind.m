//
//  HashFind.m
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "HashFind.h"

@implementation HashFind

char findFirstChar(char* cha) {
    
    char result = '\0';
    // 定义一个数组 用来存储各个字母出现次数
    int array[256];
    // 对数组进行初始化操作
    for (int i = 0 ; i < 256; i++) {
        array[i] = 0;
    }
    // 定义一个指针,只想当前字符串头部
    char* p = cha;
    // 遍历每个字符
    while (*p != '\0') {
        // 在字母对应存储位置 进行出现次数+1操作
        array[*(p++)]++;
    }
    
    // 将P指针重新指向字符串头部
    p = cha;
    // 遍历每个字母的出现次数
    while (*p != '\n') {
        // 遇到第一个出现次数为1的字符,打印结果
        if (array[*p] == 1) {
            result = *p;
            break;
        }
        // 反之极限向后遍历
        p++;
    }
    
    return result;
}

@end
