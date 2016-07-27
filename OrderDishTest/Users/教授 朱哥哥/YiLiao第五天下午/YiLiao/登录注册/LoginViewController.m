//
//  LoginViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

//登录
- (IBAction)goToMainVC:(id)sender
{
    //防止用户空操作
    if (_name.text.length == 0)
    {
        [APP_WIN showHUDWithText:@"用户名不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (_psw.text.length == 0) {
        [APP_WIN showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    [NetworkTool loginUserWithName:_name.text password:_psw.text block:^(BOOL isSuccess) {
        if (isSuccess)
        {
            //如果请求成功,跳到主界面
            [CommandTool goToMainViewController];
        }
    }];
}

//去注册界面
- (IBAction)goToRegister:(id)sender
{
    RegisterViewController *registVC = [[RegisterViewController alloc] init];
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:APP_WIN cache:YES];
    }];
    APP_WIN.rootViewController = registVC;
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
