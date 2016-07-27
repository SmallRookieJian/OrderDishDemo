//
//  MyTabBarController.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyTabBarController.h"
#import "eChatCenterViewController.h"
#import "NewsViewController.h"
#import "FileViewController.h"
#import "IndividualCenterViewController.h"


@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    [self assembleVC];
    [self configurateMyTabBar];
    
    
    //我打算在加载tabBar界面的时候，，，获取一下用户的信息
    //但是，，，有一项功能就不能完成了，，，，这项功能在新闻界面提到，就是（新闻接口是一个公共接口，不需要用户登录也能查看相关信息）
    
    
    
    
    
}
//装nav
- (void)assembleVC {
    
    eChatCenterViewController *vcEChat = [[eChatCenterViewController alloc] init];
    UINavigationController *navEChat = [[UINavigationController alloc] initWithRootViewController:vcEChat];
    NewsViewController *vcNews = [[NewsViewController alloc] init];
    UINavigationController *navNews = [[UINavigationController alloc] initWithRootViewController:vcNews];
    
    UINavigationController *navFile = [[UINavigationController alloc] initWithRootViewController:[[FileViewController alloc] init]];
    UINavigationController *navIndividual = [[UINavigationController alloc] initWithRootViewController:[[IndividualCenterViewController alloc] init]];
    
    self.viewControllers = @[navEChat,navNews,navFile,navIndividual];
}
//在此处设置按钮
- (void)configurateMyTabBar {
    
    int intervalX = self.view.frame.size.width / 12;
    int verticalY = self.view.frame.size.height - 60;
    
    NSArray *arrayImagesName = @[@"main.png",@"news.png",@"file.png",@"person.png"];
    NSArray *arrayNames = @[@"主页",@"新闻",@"文件",@"个人"];
    
    UIImageView *imageViewBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, verticalY, self.view.frame.size.width, 60)];
    [self.view addSubview:imageViewBar];
    imageViewBar.backgroundColor = [UIColor colorWithRed:215.0/250 green:215.0/250 blue:215.0/250 alpha:1];
    imageViewBar.userInteractionEnabled = YES;
    
    for (int i = 0; i < 4; i++) {
        
        UIImageView *imageViewPic = [[UIImageView alloc] initWithFrame:CGRectMake(intervalX + i * 3 * intervalX, 6, 30, 30)];
        imageViewPic.image = [UIImage imageNamed:arrayImagesName[i]];
        [imageViewBar addSubview:imageViewPic];
        
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(intervalX + i * 3 * intervalX - 4, 42, intervalX + 8, 18)];
        labelName.text = arrayNames[i];
        labelName.textColor = [UIColor blueColor];
        [imageViewBar addSubview:labelName];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * 3 * intervalX + 2*i  , 0, intervalX*3 + 2, 60);
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [imageViewBar addSubview:button];
        
    }
    
}

- (void)btnClicked:(UIButton *)sender {

    self.selectedIndex = sender.tag;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
