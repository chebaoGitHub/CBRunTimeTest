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
    
    
    Person * p = [[Person alloc] init];
    [p eat];
    [p performSelector:@selector(eat)];
    
    //使用runtime来实现创建类的实例
    Person * p2 = objc_msgSend(objc_msgSend([Person class], @selector(alloc)), @selector(init));
    objc_msgSend(p2, @selector(eat));
    
    /*
     苹果从xcode 5.0 建议使用runtime
     不推荐使用消息发送机制，也就是   objc_msgSend(p, @selector(eat));
     通过这个方法可以向对象发送消息
     
     可以在buildingseting中搜索msg来找到控制消息的地方，然后把那个监听的参数改成no
     
     clang -rewrite-objc main.m
     */
    
    //向对象发送消息
    objc_msgSend(p, @selector(eat));
    
    
    
    NSURL * url = [NSURL URLWithString:@"中"];
    
    [p performSelector:@selector(run)];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
