//
//  NSURL+url.m
//  RunTimeTest
//
//  Created by chebao on 2018/1/2.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import "NSURL+url.h"
#import <objc/runtime.h>
@implementation NSURL (url)

+(void)load{
    Method URLWithStr = class_getClassMethod([NSURL class], @selector(URLWithString:));
    Method HKURL = class_getClassMethod([NSURL class], @selector(HK_URLWithStr:));
    method_exchangeImplementations(URLWithStr, HKURL);
}

//这里使用了runtime，改变了方法指向
+(instancetype)HK_URLWithStr:(NSString *)str{
    NSURL * url = [self HK_URLWithStr:str];
    if (!url) {
        NSLog(@"url is null");
    }
    return url;
}
@end
