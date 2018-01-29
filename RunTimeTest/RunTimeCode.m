//
//  RunTimeCode.m
//  RunTimeTest
//
//  Created by chebao on 2018/1/9.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import "RunTimeCode.h"
@interface RunTimeCode()
@end


@implementation RunTimeCode
-(instancetype)init{
    if (self = [super init]) {
        self.titleArray = @[@"动态添加一个类"];
    }
    return self;
}


//动态添加一个类
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
    //用一个字典装ivarName和value
    NSMutableDictionary * ivarDic = [NSMutableDictionary dictionary];
    Ivar * ivarList = class_copyIvarList([p class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        NSString * ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        id value = [p valueForKey:ivarName];
        
        if (value) {
            ivarDic[ivarName] = value;
        }else{
            ivarDic[ivarName] = @"值为nil";
        }
    }
    
    //打印ivar
    for (NSString * ivarName in ivarDic.allKeys) {
        NSLog(@"ivarNme:%@,ivarValue:%@",ivarName,ivarDic[ivarName]);
    }
    
    // 2.打印所有properties
    unsigned int propertyCount = 0;
    // 用一个字典装propertyName和value
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    objc_property_t *propertyList = class_copyPropertyList([p class], &propertyCount);
    for(int j = 0; j < propertyCount; j++){
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(propertyList[j])];
        id value = [p valueForKey:propertyName];
        
        if (value) {
            propertyDict[propertyName] = value;
        } else {
            propertyDict[propertyName] = @"值为nil";
        }
    }
    // 打印property
    for (NSString *propertyName in propertyDict.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyDict[propertyName]);
    }
    
    // 3.打印所有methods
    unsigned int methodCount = 0;
    // 用一个字典装methodName和arguments
    NSMutableDictionary *methodDict = [NSMutableDictionary dictionary];
    Method *methodList = class_copyMethodList([p class], &methodCount);
    for(int k = 0; k < methodCount; k++){
        SEL methodSel = method_getName(methodList[k]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSel)];
        
        unsigned int argumentNums = method_getNumberOfArguments(methodList[k]);
        
        methodDict[methodName] = @(argumentNums - 2); // -2的原因是每个方法内部都有self 和 selector 两个参数
    }
    // 打印method
    for (NSString *methodName in methodDict.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodDict[methodName]);
    }
    
}

+(void)controlProperty{
    
}
+(void)voidError{
    
}
@end






































