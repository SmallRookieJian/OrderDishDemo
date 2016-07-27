//
//  FirstViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

/*
 
 在这一页，主要是为了手动写一个导航，为了在下一页（也就是登陆界面上）有导航条
 
 */



#import "FirstViewController.h"
#import "LoginViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginViewController *vcLogin = [[LoginViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcLogin];
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = nav;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
