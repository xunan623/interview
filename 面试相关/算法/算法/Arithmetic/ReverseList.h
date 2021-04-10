//
//  ReverseList.h
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//  链表反转 头插法

#import <Foundation/Foundation.h>

// 定义一个链表
struct Node {
    int data;
    struct Node *next;
};

@interface ReverseList : NSObject

// 链表反转
struct Node* reverseList(struct Node *head);
// 构造一个链表
struct Node* constructList(void);
// 打印链表中的数据
void printList(struct Node *head);

@end

