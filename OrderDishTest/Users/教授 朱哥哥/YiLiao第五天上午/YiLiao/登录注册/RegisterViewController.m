//
//  RegisterViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)goBack:(id)sender
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [UIView animateWithDuration:0.7 animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:APP_WIN cache:YES];
    }];
    APP_WIN.rootViewController = vc;
}
//确认注册
- (IBAction)confirmToRegist:(id)sender
{
    //防止空用户名和空密码或密码验证错误
    if (_userName.text.length == 0)
    {
        [APP_WIN showHUDWithText:@"用户名不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (_psw.text.length == 0) {
        [APP_WIN showHUDWithText:@"密码不能为空" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    if (![_psw.text isEqualToString:_confirmPsw.text]) {
        [APP_WIN showHUDWithText:@"两次输入密码不一致" Type:ShowPhotoNo Enabled:YES];
        return;
    }
    //发送注册请求
    [NetworkTool registNewUserWithName:_userName.text passWord:_psw.text nickName:_nickName.text email:_email.text block:^(BOOL isSuccess) {
        if (isSuccess)
        {
            [APP_WIN showHUDWithText:@"注册成功" Type:ShowPhotoYes Enabled:YES];
            [self performSelector:@selector(goback) withObject:nil afterDelay:1];
        }
    }];
}

//返回登录界面
- (void)goback
{
    [self goBack:nil];
}







@end
