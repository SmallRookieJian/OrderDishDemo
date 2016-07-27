//
//  DrawView.m
//  DrawDemo
//
//  Created by 邓鹏飞 on 16/3/31.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


-(id)init
{
    if (self = [super init]) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCurrentLine) userInfo:nil repeats:YES];
        
        _movePoint.x  = 10;
        _movePoint.y  = 10;
    }

    return self;
}


-(void)updateCurrentLine
{

    
    _movePoint.x  += 10;
    _movePoint.y  += 10;
    
    NSLog(@"---%f",_movePoint.x);
    
    
    //如果想重新绘制 当前视图内的内容
//    不能直接调用drawRect 方法
    
//    只能调用当前view的重新绘制方法
    [self setNeedsDisplay];
    
    
}

/*
   如果想要绘画的话就打开这个方法
 但是如果是一个空的方法放在这里会产生不利的影响
// drawRect这个方法实现是进行显示绘制的一个重要方法
 有一个渲染机制 ---是相当消耗内存
 
 drawRect 方法一旦被打开 那么系统在运行的过程中会为当前view分配渲染的内存
 
 drawRect 这个方法是系统自己去调用的  我们不能直接调用
 //绘制的时候使用的方法
 //绘制只能在UIView中实现
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    想要进行绘制 需要找到一个画布
//    绘制域  图形的上下文  在这个方法内只需要声明一次 就可以一直使用
//    直接获取当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
//     *******画一个矩形*******
    
//    context 表示我在这个上下文中绘制
    CGRect drawRect = CGRectMake(10, 20, 64, 44);
    CGContextAddRect(context, drawRect);
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
//    开始绘制 上边设置的内容
    CGContextStrokePath(context);
    
    
    
//    *******画一条线*******
//    CGContextSetRGBFillColor 填充色
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextSetLineWidth(context, 10);
//    设置线的起点
    CGContextMoveToPoint(context, 90, 20);
//    设置终点
    CGContextAddLineToPoint(context, 90, 60);
    
//    设置两个终端的样式
    CGContextSetLineCap(context, kCGLineCapRound);
    
//  上一个strolePath 下边的内容
//    如果之前设置过某一个属性 而下边没有设置 那么会继续沿用上边最后一次设置过的属性
    CGContextStrokePath(context);
    
    
    
    //    *******画一条折线*******
    
    CGContextMoveToPoint(context, 110, 20);
    //    设置第一条线的终点
    CGContextAddLineToPoint(context, 130, 60);
//    CGContextMoveToPoint(context, 110, 60);
    //    设置第二条线的终点
    CGContextAddLineToPoint(context, 200, 20);
//     CGContextAddLineToPoint(context, 220, 80);
    
//    设置线的折角样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextStrokePath(context);
    
    
    
    
    //    *******画一个三角形*******
    
    CGContextMoveToPoint(context, 10, 100);
    
//    for (int i = 0; i<9; i++) {  如果是多边形 用这种方式去实现
    
        //    设置第一条线的终点
        CGContextAddLineToPoint(context, 40, 160);
//    }
   
    //    设置第二条线的终点
//    CGContextAddLineToPoint(context, 80, 100);
    
//    CGContextAddLineToPoint(context, 10, 100);
    
//    找到两个终点 然后封闭起来
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
    
    
    //画圆  ----画弧
    /*
     <#CGContextRef  _Nullable c#>, 画布
     <#CGFloat x#>, <#CGFloat y#>,   中心点
     <#CGFloat radius#>,     半径
     <#CGFloat startAngle#>,  起始角度
     <#CGFloat endAngle#>,   结束角度
     <#int clockwise#>   顺时针或逆时针   1 顺时针   0 逆时针
     
     */
    
    
    CGContextAddArc(context, 200, 150, 50, 0, M_PI_2 * 4, 0);
    
    CGContextStrokePath(context);
    
    
    
//    画一个椭圆 Ellipse   矩形的内切圆
    
    CGRect ellipseRect = CGRectMake(10, 200, 100, 50);
    
    CGContextAddEllipseInRect(context, ellipseRect);
    
    CGContextStrokePath(context);
    
    //绘制文字
    
    
    NSString *string = @"这是一串文字";
    
//    绘制文字 是NSString的方法
//    需要传入 两个参数 一个是rect 表明我这个文字画在哪个区域
//      字典  字号 颜色  字体
    
    CGRect stringRect = CGRectMake(10,300 , 200, 50);
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor redColor]};
    [string drawInRect:stringRect withAttributes:dict];
  
//    绘制文字不需要实现
//    CGContextStrokePath(context);

    //绘制图片
    
    
    UIImage *imag = [UIImage imageNamed:@"222.jpg"];
    
    CGRect imgRect = CGRectMake(10, 400, 100, 100);
    [imag drawInRect:imgRect];
    
    
    
//    动态的画一条线
    
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextSetLineWidth(context, 20);
    CGContextMoveToPoint(context, 0, 0);
    
//    线是动态的 终点是不断改变的
    CGContextAddLineToPoint(context,self.movePoint.x ,self.movePoint.y);
    CGContextStrokePath(context);
    
}













@end
