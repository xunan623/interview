//
//  AppDelegate.m
//  算法
//
//  Created by xunan on 2019/9/2.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "AppDelegate.h"
#import "CharReverse.h"
#import "ReverseList.h"
#import "MergeSortedList.h"
#import "HashFind.h"
#import "MedianFind.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 字符串反转
    char ch[] = "hello,world";
    char_reverse(ch);
    printf("reverse result is %s \n", ch);
    
//    // 单链表反转
//    struct Node* head = constructList();
//    printList(head);
//
//    printf("------------\n");
//
//    // 这里会偶尔崩溃
//    struct Node* newHead = reverseList(head);
//    printList(newHead);
    
    printf("------------\n");

    // 有序数组归并
    int a[5] = {1, 4, 6, 7, 9};
    int b[8] = {2, 3, 5, 6, 8, 10, 11, 12};

    // 用于存储归并结果
    int result[13];
    // 归并操作
    mergeList(a, 5, b, 8, result);
    // 打印归并结果
    printf("merge result is ");
    for (int i = 0; i < 13; i++) {
        printf(" %d", result[i]);
    }
    
    printf("------------\n");

    // 查找第一个只出现一次的字符
    char cha[] = "abaccdeff";
    char fc = findFirstChar(cha);
    printf("this char is %c \n", fc);
    
    printf("------------\n");

    int list[11] = {12, 3, 10, 8, 6, 7, 11, 13, 9, 14, 15};
    // 3 6 7 8 9 10 11 12 13 14 15
    
    int median = findMedian(list, 11);
    printf("the median is %d \n", median);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
