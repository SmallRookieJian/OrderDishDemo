//
//  People.h
//  KVCDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface People : NSObject
{
//    成员变量 只能在当前类中可以调用
//    get
     BOOL sex;
    
}

@property (nonatomic,strong) Car *car;
//属性声明完成后就自带一个set 和get方法
//可以被外部类调用到
@property (nonatomic,copy)NSString *name;
@property (nonatomic) NSInteger height;









@end
