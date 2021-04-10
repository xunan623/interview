//
//  AppDelegate.m
//  KVO
//
//  Created by xunan on 2019/9/8.
//  Copyright © 2019 centanet. All rights reserved.
//

#import "AppDelegate.h"
#import "MObject.h"
#import "MOServer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    MObject *obj = [[MObject alloc] init];
    MOServer *observer = [[MOServer alloc] init];

    // 调用kvo方法监听obj的value属性的变化
    [obj addObserver:observer forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:NULL];
    // po object_getClassName(obj) MObject
    
    // 修改value的值
    obj.value = 1;
    // po object_getClassName(obj) NSKVONotifying_MObject
    
    // 1.通过kvc赋值能否生效? 可以 因为调用了Setter方法
    [obj setValue:@2 forKey:@"value"];
    
    // 2.通过成员变量赋值能否生效? 不行 因为没有调用Setter方法 只调用了getter方法
    [obj increase];
    
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
