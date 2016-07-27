//
//  CommandTool.m
//  YiLiao
//
//  Created by MrCheng on 16/3/15.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "CommandTool.h"
#import "ChatViewController.h"
#import "FileViewController.h"
#import "NewsViewController.h"
#import "SettingViewController.h"
@implementation CommandTool

//跳主界面
+ (void)goToMainViewController
{
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    chatVC.navigationItem.title = @"聊天中心";
    UINavigationController *navChat = [[UINavigationController alloc] initWithRootViewController:chatVC];
    navChat.tabBarItem.title = @"主页";
    navChat.tabBarItem.image = [UIImage imageNamed:@"main.png"];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    newsVC.navigationItem.title = @"新闻中心";
    UINavigationController *navNews = [[UINavigationController alloc] initWithRootViewController:newsVC];
    navNews.tabBarItem.title = @"新闻";
    navNews.tabBarItem.image = [UIImage imageNamed:@"news.png"];
    
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    settingVC.navigationItem.title = @"设置中心";
    UINavigationController *navSetting = [[UINavigationController alloc] initWithRootViewController:settingVC];
    navSetting.tabBarItem.title = @"设置";
    navSetting.tabBarItem.image = [UIImage imageNamed:@"person.png"];
    
    FileViewController *fileVC = [[FileViewController alloc] init];
    fileVC.navigationItem.title = @"文件中心";
    UINavigationController *navFile = [[UINavigationController alloc] initWithRootViewController:fileVC];
    navFile.tabBarItem.title = @"文件";
    navFile.tabBarItem.image = [UIImage imageNamed:@"file.png"];
    
    tabBar.viewControllers = @[navChat,navNews,navFile,navSetting];
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:APP_WIN cache:YES];
    }];
    APP_WIN.rootViewController = tabBar;
}

//计算文本高度
+ (CGRect)getTextRectWithString:(NSString *)str withWidth:(NSInteger)width withFontSize:(NSInteger)size
{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    return rect;
}










@end
