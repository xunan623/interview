//
//  main.m
//  OC的本质
//
//  Created by xunan on 2019/11/20.
//  Copyright © 2019 centanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface Student : NSObject {

    @public
    int _no;
    int _age;
}

@end

@implementation Student

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Student *stu = [[Student alloc] init];
        stu->_age = 4;
        stu->_age = 5;
        NSLog(@"%p", stu); 
        
        NSObject *obj = [[NSObject alloc] init];
        
        NSLog(@"%zd", class_getInstanceSize(obj.class));
        
        NSLog(@"%zd", malloc_size((__bridge const void *)(obj)));

        
    }
    return 0;
}
