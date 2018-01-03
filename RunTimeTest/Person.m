//
//  Person.m
//  RunTimeTest
//
//  Created by chebao on 2018/1/2.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person
-(void)eat{
    NSLog(@"has eat");
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    class_addMethod([Person class], sel, (IMP)run, nil);
    return [super resolveInstanceMethod:sel];
}

void run(id obj,SEL _cmd){
    NSLog(@"runrunrun%@",obj);
}


@end
