//
//  ViewController.h
//  KVODemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

//kvo 观察者模式
//该模式中 观察者和被观察者没有直接关系
//观察者可以监测 被观察者的动向
// 是一对多的关系
//利用的是kvc的原理 直接监测内存的改变 根据属性名
//一般可以监测 属性 变量 或者某一个类
//不能监测 一个方法的改变
//kvo利用的是kvc的原理 属性名被修改了以后就监测不到数据了


//代理
// 一般是次级类向上级类传递消息时使用
//视图类向 视图控制器类传递消息
//非常清晰 方法或非常直观


//block  传递消息用的
//一般使用在model和控制器之间的传值
//一般也是次级类向上级类传递消息
//比代理少写 协议  但是关系比较模糊

//通知 kvo 观察者和被观察者之间关系非常模糊

//通知 一般使用在那些功能上 ----登录
//通知 只能发送最新值
// 设置里写一个通知中心 在每一个设置里写一个接受者 接收到响应事件后进行改变

//KVO 改变背景色 等设置功能
//只需要声明 我要监测那个数据
//实现 监测到数据后返回的回调


//kvo 如果检测的对象不存在 不会造成崩溃
//首先检测属性中是否存在 再去检测成员变量
//再去检测私有变量  直接抛弃
//所以 kvo 不需要担心检测对象不存在的问题


//kvo尽量少用 查找它非常困难

//kvo 实现 只有三个方法

//kvo 可以返回新值以及老值
//NSKeyValueObservingOptionOld
//NSKeyValueObservingOptionNew
//kvo 添加监听事件
//[self addObserver:self forKeyPath:@"要监测的对象" options:NSKeyValueObservingOptionNew context:nil];
//删除监听  一般在dellaloc中删除
//[self removeObserver:self forKeyPath:@"要删除的监测对象"];

//监听成功 返回数据的方法
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//}





#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

