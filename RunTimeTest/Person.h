//
//  Person.h
//  RunTimeTest
//
//  Created by chebao on 2018/1/2.
//  Copyright © 2018年 jirui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,assign) float weight;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger age;

-(void)eat;
@end
