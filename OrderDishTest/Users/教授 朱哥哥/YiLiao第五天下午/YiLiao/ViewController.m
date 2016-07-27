//
//  ViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/15.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self goToLoginOrMainVC];
    
}
//判断是否自动登录
- (void)goToLoginOrMainVC
{
    if ([self isLogined])
    {
        //如果已经登录,跳转主页
        [CommandTool goToMainViewController];
    }
    else
    {
        //如果没登录,去登录界面
        [self goToLogin];
    }
}

//判断是否已经登录
- (BOOL)isLogined
{
    NSString *toke = [USER_DEF objectForKey:USER_TOKEN];
    if (toke)
    {
        //如果token存在,再判断时间是否过期
        NSDate *date = [USER_DEF objectForKey:USER_DEADTIME];
        NSDate *now = [NSDate date];
        if ([now compare:date] == NSOrderedAscending)
        {
            return YES;
        }
            return NO;
    }
    return NO;
}

//去登录界面
- (void)goToLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    APP_WIN.rootViewController = loginVC;
    
}












@end
