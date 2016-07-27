//
//  ViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

/*
 
 这一页主要放了一张与程序启动图片一样的背景
 点击屏幕能动画切换到下一页去
 
 
 */






#import "ViewController.h"
#import "LoginViewController.h"
#import "FirstViewController.h"

#import "MyTabBarController.h"


@interface ViewController ()
{
  
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *imageViewBG = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageViewBG.image = [UIImage imageNamed:@"1.png"];
    [self.view addSubview:imageViewBG];
    
#pragma mark 在这里加载其他页面
    
    if ([self isTokenExpire]) {
        [self loadOtherVC];
    }
}
//判断token是否过期
- (BOOL)isTokenExpire {
    
    NSDate *expire_time = [[NSUserDefaults standardUserDefaults] objectForKey:@"expire_time"];
    
    if ([expire_time compare:[NSDate date]] == NSOrderedAscending) {
        return NO;
    }
    
    
    return YES;
}


- (void)loadOtherVC {
    
    MyTabBarController *myTabBar = [[MyTabBarController alloc] init];
    
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = myTabBar;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    
//    LoginViewController *vcLogin = [[LoginViewController alloc] init];
    FirstViewController *vcFirst = [[FirstViewController alloc] init];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:win cache:YES];
    
    win.rootViewController = vcFirst;
    
    [UIView commitAnimations];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
