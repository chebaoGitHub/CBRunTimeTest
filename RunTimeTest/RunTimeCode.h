//
//  RunTimeCode.h
//  RunTimeTest
//
//  Created by chebao on 2018/1/9.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"


//一、动态添加一个类

/*二、通过runtime获取一个类的所有属性，我们可以做些什么？
 1. 打印一个类的所有ivar, property 和 method（简单直接的使用）
 2. 动态变量控制
 3. 在NSObject的分类中增加方法来避免使用KVC赋值的时候出现崩溃
 */


@interface RunTimeCode : NSObject
+(void)chuangJanYiGeLei;
@property (nonatomic,strong) NSArray * titleArray;

@end
