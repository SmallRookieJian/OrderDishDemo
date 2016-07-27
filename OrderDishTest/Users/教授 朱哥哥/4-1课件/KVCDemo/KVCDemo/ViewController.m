//
//  ViewController.m
//  KVCDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize name = _name; //设置 name的set和get方法



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _people = [[People alloc]init];
    
//    这种方式set可以获取内容
    NSLog(@"people.name = %@",_people.name);
//        _people.sex  调用不到的
    
//  kvc也可以查找属性 根据他的属性名
//    可以直接查找到属性内容
//    我们不需要实现set和get方法依然可以使用
    NSLog(@"people.name2 = %@",[_people valueForKey:@"name"]);
//    kvc 直接查找内存
    NSLog(@"peope.sex = %ld",[[_people valueForKey:@"sex"] integerValue]);
    
//    修改属性
    _people.name = @"张三";
    NSLog(@"---%@",_people.name);
//    kvc 可以直接修改内容
//    kvc最大的缺陷就是 key必须是存在的 如果不存在 那么会造成野指针
    [_people setValue:@"李四" forKey:@"name"];
    
    NSLog(@"---%@",_people.name);

    Car *car = [[Car alloc]init];
    
//    _people.car = car;
    [_people setValue:car forKey:@"car"];
    
    NSLog(@"---car.colr ==%@",_people.car.color);
//    调用汽车的name 需要有两层调用
//    NSLog(@"car.name == %@",[[_people valueForKey:@"car"] valueForKey:@"_name"]);
    
//    kvc 有两种去内存方式 一种是直接查找当前需要查找的对象名  一种是根据他的路径查找
//    kvc 只能调用 当前声明过的属性内容
    NSLog(@"car.name =%@",[_people valueForKeyPath:@"car._name"]);
    
    [_people setValue:@"BYD" forKeyPath:@"car._name"];
    NSLog(@"---car.name ==%@",[_people valueForKeyPath:@"car._name"]);
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
