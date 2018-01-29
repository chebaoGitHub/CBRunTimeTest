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
#import "RunTimeCode.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) NSArray * titleArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    RunTimeCode * rt = [[RunTimeCode alloc] init];
    self.titleArray = rt.titleArray;
    
    
    _table = [[UITableView alloc] init];
    _table.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    _table.backgroundColor = [UIColor lightGrayColor];
    _table.delegate = self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    

    
    
    //只是一些临时代码########################################################################################
//    [self linshi];
    
    //潭州的runtime公开课
//    [self tanzhou];
    
}

#pragma mark- table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [RunTimeCode chuangJanYiGeLei];
    }
}

#pragma mark- 临时代码的一部分
-(void)linshi{
    /*    NSMethodSignature苹果官方定义该类为对方法的参数、返回类似进行封装，
     协同NSInvocation实现消息转发。
     通过消息转发实现类似C++中的多重继承。
     */
    int a = 1;
    int b = 2;
    int c = 3;
    SEL myMethod = @selector(myLog:param:parm:);
    SEL myMethod2 = @selector(myLog);
    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量要和调用的一致。
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:myMethod];
    // 通过签名初始化
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    // 2.FirstViewController *view = self;
    // 2.[invocation setArgument:&view atIndex:0];
    // 2.[invocation setArgument:&myMethod2 atIndex:1];
    // 设置target
    // 1.[invocation setTarget:self];
    // 设置selector
    [invocation setSelector:myMethod];
    // 注意：1、这里设置参数的Index 需要从2开始，因为前两个被selector和target占用。
    [invocation setArgument:&a atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation setArgument:&c atIndex:4];
    // [invocation retainArguments];
    // 我们将c的值设置为返回值
    [invocation setReturnValue:&c];
    int d;
    // 取这个返回值
    [invocation getReturnValue:&d];
    NSLog(@"d:%d", d);
    
    NSUInteger argCount = [sig numberOfArguments];
    NSLog(@"argCount:%ld", argCount);
    
    for (NSInteger i=0; i<argCount; i++) {
        NSLog(@"%s", [sig getArgumentTypeAtIndex:i]);
    }
    NSLog(@"returnType:%s ,returnLen:%ld", [sig methodReturnType], [sig methodReturnLength]);
    NSLog(@"signature:%@" , sig);
    
    // 消息调用
    [invocation invokeWithTarget:self];
}
- (int)myLog:(int)a param:(int)b parm:(int)c
{
    NSLog(@"MyLog:%d,%d,%d", a, b, c);
    return a+b+c;
}

- (void)myLog
{
    NSLog(@"你好,South China University of Technology");
}


#pragma mark- 潭州
-(void)tanzhou{
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
