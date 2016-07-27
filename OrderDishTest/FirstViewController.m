//
//  FirstViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "PushTool.h"
#import "ManagerLoginViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    
}


//点菜系统 按钮
- (IBAction)orderBtn:(id)sender
{
    SecondViewController *vc = [[SecondViewController alloc]init];
    [PushTool goToNextVC:vc];
    
}
//网站首页 按钮
- (IBAction)homePageBtn:(id)sender
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
}
/*
   应用程序间的跳转
 A程序跳到B程序 在B程序的工程里的Tagets--->info-----> URL types ---->URL schemes 设置appB
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"appB://"]];

*/

//管理员系统按钮
- (IBAction)btnManagerSystemClicked:(id)sender {
    
    ManagerLoginViewController *viewControllerManageLogin = [[ManagerLoginViewController alloc] init];
    
    [self.navigationController pushViewController:viewControllerManageLogin animated:YES];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
