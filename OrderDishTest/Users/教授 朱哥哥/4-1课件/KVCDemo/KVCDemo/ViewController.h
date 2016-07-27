//
//  ViewController.h
//  KVCDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
#import "Car.h"

//KVC  Key value coding 键值编码 查找或者修改属性的一个方法
//不需要通过set 或者get方法 可以直接获取一个属性的内容
// 可以直接通过 他的key 直接获取value
// 本质上来讲就是通过这个key关键字 去内存中直接查找内容
//kvc 缺点 key值必须是存在的 如果不存在会造成野指针
//kvc 不需要关心查找的内容是属性还是变量

// kvc 查找顺序 先查找属性 成员变量 私有变量


@interface ViewController : UIViewController
{
        NSString* _name;
    
    
    People *_people;
}

@property (nonatomic,strong) NSString *name;







@end

