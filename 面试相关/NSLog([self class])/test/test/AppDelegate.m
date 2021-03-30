//
//  AppDelegate.m
//  test
//
//  Created by xunan on 2021/3/22.
//

#import "AppDelegate.h"
#import "Phone.h"

@interface AppDelegate ()

@property (nonatomic, copy) int(^blk)(int num);
@property (nonatomic, copy) NSString *name;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    int mut = 6;
    int (^Block)(int num) = ^(int num) {
        return num * mut;
    };
    NSLog(@"%d", Block(2));
    
    __block int multplier = 10;
    _blk = ^int(int num) {
        self->_name = @"哈哈哈";
        return num * multplier;
    };
    multplier = 6;
    [self executeBlock];

    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
        
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        [self performSelector:@selector(prntLog) withObject:nil afterDelay:0];
        NSLog(@"3");
    });
    
    
    
    return YES;
}

- (void)prntLog {
    NSLog(@"2");
}

- (void)executeBlock {
    int result = _blk(4);
    NSLog(@"result is %d", result);
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


@end
