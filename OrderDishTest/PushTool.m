//
//  PushTool.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "PushTool.h"

@implementation PushTool

//这是push 页面工具

+ (void)goToNextVC:(UIViewController *)vc
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
    [UIView transitionWithView:window duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:nil];
}
@end
