//
//  RegistViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/11.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "RegistViewController.h"
#import "ASIFormDataRequest.h"
#import "Request.h"

@interface RegistViewController ()<ASIHTTPRequestDelegate>
{
    __weak IBOutlet UITextField *_textFieldUserName;
    __weak IBOutlet UITextField *_textFieldPassword;
    __weak IBOutlet UITextField *_textFieldCertainPsw;
    __weak IBOutlet UITextField *_textFieldNackName;
    __weak IBOutlet UITextField *_textFieldEmail;
}


@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self configurateImageViewBG];
    
    
}

- (void)configurateImageViewBG {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    imageView.image = [UIImage imageNamed:@"loginbg.jpg"];
    [self.view addSubview:imageView];
    
}

- (IBAction)btnRegisteClicked:(id)sender {
    
    NSString *userName = _textFieldUserName.text;
    NSString *psw = _textFieldPassword.text;
    NSString *pswCertain = _textFieldCertainPsw.text;
    NSString *nickname = _textFieldNackName.text;
    NSString *email = _textFieldEmail.text;
    
    //首先判断密码，用户名是否为空，，为空的话直接提示输入
    if (!userName.length > 0) {
        [self configurateAlertControllerWithMessage:@"用户名为空，请重新输入"];
        return;
        
    }
    
    if (!psw.length > 0) {
        [self configurateAlertControllerWithMessage:@"密码为空，请重新输入"];
        return;
    }
    //两个密码不相同的话，直接显示密码不一样
    if (![psw isEqualToString:pswCertain]) {
        [self configurateAlertControllerWithMessage:@"您两次输入的密码不一样，请重新输入"];
        return;
    }
#pragma mark 此处用的block实现
    [Request registeUser:userName WithPsw:psw WithNickname:nickname WithEmail:email WithResultBlock:^(NSDictionary *dic) {
        
//        NSLog(@"这是传值回来的dic%@",dic);
        NSString *result = [dic objectForKey:@"result"];
        
        
        if ([result isEqualToString:@"1"]) {
            [self configurateAlertControllerWithMessage:@"注册成功"];
        }
        else
        {
            
            NSString *error = [dic objectForKey:@"error"];
            
            [self configurateAlertControllerWithMessage:[NSString stringWithFormat:@"注册失败,%@",error]];
        }
        
        
    }];
    
    
#pragma mark 这里用的协议方法实现
//    //向服务器发送请求
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
//    request.delegate = self;
////    [request setValue:@"ST_R" forKey:@"command"];
//    [request setPostValue:@"ST_R" forKey:@"command"];
//    [request setPostValue:userName forKey:@"name"];
//    [request setPostValue:psw forKey:@"psw"];
//    
//    if (nickname.length) {
//        [request setPostValue:nickname forKey:@"nickname"];
//    }
//    if (email.length) {
//        [request setPostValue:email forKey:@"email"];
//    }
//    
//    [request startSynchronous];

}


#pragma mark 这里用的协议方法实现
//- (void)requestFailed:(ASIHTTPRequest *)request {
//    
//    NSLog(@"发送失败，，，返回的内容为：%@",request.responseString);
//    
//}
//- (void)requestFinished:(ASIHTTPRequest *)request {
//    NSLog(@"resopnseStatusCode___%d",request.responseStatusCode);
////    NSLog(@"%@",request.responseString);
//    
//    NSError *error = nil;
//    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:&error];
//    
//    if (responseDic.count > 1) {
//        
//        NSLog(@"您输入的用户名已存在，请重新输入");
//        return;
//        
//    }
//    
//    NSLog(@"注册成功");
//
//}


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
    // Dispose of any resources that can be recreated.
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
