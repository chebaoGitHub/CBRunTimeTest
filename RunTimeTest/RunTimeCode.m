//
//  RunTimeCode.m
//  RunTimeTest
//
//  Created by chebao on 2018/1/9.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import "RunTimeCode.h"


@implementation RunTimeCode
+(void)chuangJanYiGeLei{
    // 创建一个类(size_t extraBytes该参数通常指定为0, 该参数是分配给类和元类对象尾部的索引ivars的字节数。)
    Class clazz = objc_allocateClassPair([NSObject class], "GoodPerson", 0);
    
    // 添加ivar
    // @encode(aType) : 返回该类型的C字符串
    class_addIvar(clazz,"_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addIvar(clazz, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
    
    
    // 注册该类
    objc_registerClassPair(clazz);
    
    // 创建实例对象
    id object = [[clazz alloc] init];
    
    // 设置ivar
    [object setValue:@"Tracy" forKey:@"name"];
    
    Ivar ageIvar = class_getInstanceVariable(clazz, "_age");
    object_setIvar(object, ageIvar, @18);
    
    // 打印对象的类和内存地址
    NSLog(@"%@", object);
    
    // 打印对象的属性值
    NSLog(@"name = %@, age = %@", [object valueForKey:@"name"], object_getIvar(object, ageIvar));
    
    // 当类或者它的子类的实例还存在，则不能调用objc_disposeClassPair方法
    object = nil;
    
    // 销毁类
    objc_disposeClassPair(clazz);
}

+(void)logAllProperty{
    Person * p = [[Person alloc] init];
    [p setValue:@"Kobe" forKey:@"name"];
    [p setValue:@18 forKey:@"age"];
    p.weight = 110.0f;
    
    //1.打印所有ivars
    unsigned int ivarCount = 0;
    
}

+(void)controlProperty{
    
}
+(void)voidError{
    
}
@end
