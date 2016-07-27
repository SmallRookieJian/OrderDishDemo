//
//  ManagerLoginViewController.m
//  OrderDishTest
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ManagerLoginViewController.h"
#import "OrdinaryManagerViewController.h"
#import "SystemManagerViewController.h"
#import "BmobTool.h"
#import "XJAlertController.h"

@interface ManagerLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (weak, nonatomic) IBOutlet UISwitch *switchKind;


@end

@implementation ManagerLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor colorWithRed:23/250.0 green:15/250.0 blue:12/250.0 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:color];
//    self.navigationItem.title = @"管理员登录";
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    labelTitle.text = @"管理员登录";
    [labelTitle setFont:[UIFont systemFontOfSize:25]];
    [labelTitle setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = labelTitle;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    self.navigationController.navigationBarHidden = NO;
//    self.view.backgroundColor = [UIColor cyanColor];
    
    
    
    
    
}

- (IBAction)btnLoginClicked:(id)sender {
    
    BmobTool *bmobManager = [BmobTool shareBmobManager];
    [bmobManager bmob_loginManagerSystemWithName:self.textFieldUserName.text withPassword:self.textFieldPassword.text withBlock:^(BOOL isSuccess) {
       
        if (!isSuccess) {
            
            //登录失败
            
//            [XJAlertController alertControllerTitle:@"温馨提示" WithMessage:@"对不起，登录失败" WithDismissTime:3];
            XJAlertSet *set = [[XJAlertSet alloc] init];
            //这个是alertViewController的风格
            set.alertControllerStyle = 1;
            set.title = @"温馨提示";
            //在这个数组中可以写任意数量的名字，都可以添加到alertViewController上
            set.arrActionNames = @[@"确定"];
            set.message = @"亲，登录错误！请重新输入！";
            XJAlertController *alertController = [XJAlertController XJalertControllerWithParameter:set clickedBlock:^(NSInteger btnIndex) {
                if (btnIndex == 0) {
                    //可以什么也不用做了
                }
                
            }];
            [self presentViewController:alertController animated:YES completion:nil];
            
            return;
        }
        
        //登陆成功
        
//        XJAlertController *alert = [XJAlertController alertControllerTitle:@"温馨提示" WithMessage:@"登陆成功" WithDismissTime:3];
//        [self presentViewController:alert animated:YES completion:^{
            if (self.switchKind) {
                //这是普通管理员
                OrdinaryManagerViewController *viewControllerOrdinaryManager = [[OrdinaryManagerViewController alloc] init];
                [self.navigationController pushViewController:viewControllerOrdinaryManager animated:YES];
                
            }
            else {
                //这是系统管理员
                SystemManagerViewController *viewControllerSystemManager = [[SystemManagerViewController alloc] init];
                [self.navigationController pushViewController:viewControllerSystemManager animated:YES];
                
            }
        }];
        
//    }];
    
    
//    OrdinaryManagerViewController *viewControllerOrdinaryManager = [[OrdinaryManagerViewController alloc] init];
//    [self.navigationController pushViewController:viewControllerOrdinaryManager animated:YES];
    
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
