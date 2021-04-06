//
//  main.m
//  interview-block
//
//  Created by xunan on 2021/3/31.
//

#import <Foundation/Foundation.h>
#import "MJPerson.h"

typedef void (^TestBlock) (void);

TestBlock myBlock() {
    
    return ^{
        NSLog(@"----");
    };
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
            
//        void (^block)(void) = ^{
//            NSLog(@"这是个block");
//        };
//        block();
        
//        TestBlock block = myBlock();
//        block();
//
//        int age = 10;
//        TestBlock testBlock = ^{
//            NSLog(@"--------%d", age);
//        };
        
        
//        MJPerson *person = [[MJPerson alloc] init];
//        person.age = 10;
//
//        TestBlock block = ^{
//            NSLog(@"----- %zd", person.age);
//        };
//        block();
//        NSLog(@"%@", [block class]);
        
//        TestBlock block;
//        {
//            MJPerson *person = [[MJPerson alloc] init];
//            person.age = 10;
//            block = ^{
//                NSLog(@"------%zd", person.age);
//            };
//        }
//        NSLog(@"------");
        
        
        TestBlock block;
        {
            MJPerson *person = [[MJPerson alloc] init];
            person.age = 10;
            __weak MJPerson *weakPerson = person;
            block = ^{
                NSLog(@"------%zd", weakPerson.age);
            };
        }
        NSLog(@"------");

    }
    return 0;
}
