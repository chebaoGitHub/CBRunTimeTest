//
//  ViewController.m
//  RunTimeTest
//
//  Created by chebao on 2018/1/2.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import "NSURL+url.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     这部分是潭州的runtime课程
     1 把oc的方法调用使用runtime代码写出来
     2 使用runtime交换方法的实现，提高容错率
     3 动态添加方法
     4 oc对象的序列化和反序列化，也就是归档吧，但是这个网页上也讲有，就放在下面了
     
     
     苹果从xcode 5.0 建议使用runtime
     不推荐使用消息发送机制，也就是   objc_msgSend(p, @selector(eat));
     通过这个方法可以向对象发送消息
     
     可以在buildingseting中搜索msg来找到控制消息的地方，然后把那个监听的参数改成no
     
     clang -rewrite-objc main.m
     */
    
    
//    1 把oc的方法调用使用runtime代码写出来
    Person * p = [[Person alloc] init];
    [p eat];
    [p performSelector:@selector(eat)];
    
    //使用runtime来实现创建类的实例
    Person * p2 = objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    objc_msgSend(p2, @selector(eat));
    
    //向对象发送消息
    objc_msgSend(p, @selector(eat));
    
    
//    2 使用runtime交换方法的实现，提高容错率

    NSURL * url = [NSURL URLWithString:@"中"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    
    
//    3 动态添加方法  p是没有run这个方法的

    [p performSelector:@selector(run)];
    
    
    
    //下面是网页上总结的一些runtime使用########################################################################################
    
    
    
     //一、动态添加一个类
    [self chuangjian];

     /*二、通过runtime获取一个类的所有属性，我们可以做些什么？
         1. 打印一个类的所有ivar, property 和 method（简单直接的使用）
         2. 动态变量控制
         3. 在NSObject的分类中增加方法来避免使用KVC赋值的时候出现崩溃
     */
    [self logAllProperty];
    [self controlProperty];
    [self voidError];
    
    
}

-(void)chuangjian{
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

-(void)logAllProperty{
    Person * p = [[Person alloc] init];
    [p setValue:@"Kobe" forKey:@"name"];
    [p setValue:@18 forKey:@"age"];
    p.weight = 110.0f;
    
    //1.打印所有ivars
    unsigned int ivarCount = 0;
    
}

-(void)controlProperty{
    
}
-(void)voidError{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
