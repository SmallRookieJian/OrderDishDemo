//
//  LoginViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

/*
 
 现在到了登录界面了，，开始写了
 
 */


#import "LoginViewController.h"
#import "RegistViewController.h"
#import "Request.h"
#import "MyTabBarController.h"

@interface LoginViewController ()
{
    
    __weak IBOutlet UITextField *_textFieldUserName;
    __weak IBOutlet UITextField *_textFieldPassword;
    
    
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    [self configurateImageViewBG];
    
    
    
}

- (void)configurateImageViewBG {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = [UIImage imageNamed:@"loginbg.jpg"];
    [self.view addSubview:imageView];
    
}
- (IBAction)btnRegisteClicked:(id)sender {
    RegistViewController *vcRegiste = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:vcRegiste animated:YES];
    
    
}
- (IBAction)btnLoginClicked:(id)sender {
    
    NSString *userName = _textFieldUserName.text;
    NSString *psw = _textFieldPassword.text;
    if (!userName.length) {
        
        [self configurateAlertControllerWithMessage:@"请输入用户名"];
        return;
        
    }
    if (!psw.length) {
        [self configurateAlertControllerWithMessage:@"请输入密码"];
        return;
    }
    
    [Request loginUser:userName WithPsw:psw WithLoginResultBlock:^(NSDictionary *dicResult) {
        
//        NSLog(@"%@",dicResult);
        //在这里返回来了结果
        NSString *result = [dicResult objectForKey:@"result"] ;
        if ([result isEqualToString:@"0"]) {
            
            NSString *error = [dicResult objectForKey:@"error"];
            [self configurateAlertControllerWithMessage:error];
            return;
            
        }
        //到了这里就是能登录了
        NSString *access_token = [dicResult objectForKey:@"access_token"];
        NSString *time = [dicResult objectForKey:@"time"];
        NSDate *expire_date = [NSDate dateWithTimeIntervalSinceNow:[time doubleValue]];
        //在这里将用户名，密码，access_token,exprie_date存入沙盒中
        [self saveUserName:userName WithPsw:psw WithToken:access_token WithTime:expire_date];
        
        MyTabBarController *vcMyTabBar = [[MyTabBarController alloc] init];
        UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
        
#pragma mark 在这里或许会用到传值
        win.rootViewController = vcMyTabBar;
        
    }];
    
}
//配置AlertController
- (void)configurateAlertControllerWithMessage:(NSString *)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                    
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 存沙盒
- (void)saveUserName:(NSString *)userName WithPsw:(NSString *)psw WithToken:(NSString *)access_token WithTime:(NSDate *)expire_time {
    
//    NSLog(@"%@",NSHomeDirectory());
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:userName forKey:@"userName"];
    [ud setObject:psw forKey:@"psw"];
    [ud setObject:access_token forKey:@"access_token"];
    [ud setObject:expire_time forKey:@"expire_time"];
    
    
}
#pragma mark 键盘下去
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
