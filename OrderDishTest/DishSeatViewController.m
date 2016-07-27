//
//  DishSeatViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DishSeatViewController.h"
#import "SeatViewController.h"
#import "OrderTableDao.h"
#import "HistoryModel.h"
#import "BmobTool.h"
#import "MMMMViewController.h"
#import "AppDelegate.h"


#import "FirstViewController.h"
//TODO: 在这里的话，可以说是有个技术难点，就是这些textField的代理方法，VIP账号查询，工号验证等事件的处理都是用的一些回调方法，所以，在点击送单按钮时的逻辑不好处理


#define ErrorInfo @"error"
#define CorrectInfo @"correct"
#define InputInfo @"请输入"

@interface DishSeatViewController ()<UITextFieldDelegate>

//输入框部分
@property (weak, nonatomic) IBOutlet UITextField *textFieldPeopleNum;
@property (weak, nonatomic) IBOutlet UITextField *textFieldVIPNum;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWorkerNum;
@property (weak, nonatomic) IBOutlet UITextField *textFieldWorkerPassword;
@property (weak, nonatomic) IBOutlet UILabel *labelSeatChooseState;


//输入框输入状态提示标签
@property (weak, nonatomic) IBOutlet UILabel *labelPeopleNumState;
@property (weak, nonatomic) IBOutlet UILabel *labelVIPNumState;
@property (weak, nonatomic) IBOutlet UILabel *labelWorkerNumState;
@property (weak, nonatomic) IBOutlet UILabel *labelPasswardState;

@property (weak, nonatomic) IBOutlet UIButton *buttonSeatName;

@property (nonatomic, assign) BOOL canSendOrder;

@end

@implementation DishSeatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _canSendOrder = YES;
    
    /*
     
     在这里添加一个从本地读取已经存储的用户信息
     
     */
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //2.读取保存的数据
    NSString *workerNum = [defaults objectForKey:@"workerNum"];
    NSString *password = [defaults objectForKey:@"password"];
    NSLog(@"这里是沙盒路径：%@",NSHomeDirectory());
    if (workerNum && password) {
        
        _textFieldWorkerNum.text = workerNum;
        _textFieldWorkerPassword.text = password;
        
    }
    
    //在这里只是对输入框输入的基本格式进行限制
    //在这里需要对用餐人数输入框、VIP号输入框，进行设置
    _textFieldPeopleNum.keyboardType = UIKeyboardTypeNumberPad;
    
    _textFieldPeopleNum.delegate = self;
    
    _textFieldVIPNum.keyboardType = UIKeyboardTypeNumberPad;
    
    _textFieldVIPNum.delegate = self;
    
    //工号、密码输入框也需要进行设置
    _textFieldWorkerNum.keyboardType = UIKeyboardTypeNumberPad;
    
    _textFieldWorkerNum.delegate = self;
    
    _textFieldWorkerPassword.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationChangeTitle:) name:@"change" object:nil];
    
}

- (void)notificationChangeTitle:(NSNotification *)noti
{
    NSString *name = [noti.userInfo valueForKey:@"名字"];
    [self.buttonSeatName setTitle:name forState:UIControlStateNormal];
    [self.buttonSeatName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

//选择位置按钮
- (IBAction)btnSeatNameClicked:(id)sender
{
    SeatViewController *vc = [[SeatViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
    
}
//送单按钮
- (IBAction)btnSendOrderDishClicked:(id)sender
{
    __block BOOL enableSendOrderDish = YES;
    //在这里需要对输入框在最后输入时的
    
    /*
     
     前提要求：都必须不能为空
     
     就餐人数输入框   唯一限制就是只能输入数字
     
     VIP输入框         限制：1.数字   2. 6位数字
     工号输入框         限制：1.数字   2. 4位数字
     密码输入框         限制：特殊字符、密码位数
     
     */
    
    if (!self.textFieldWorkerNum.text) {
        
        self.labelWorkerNumState.text = InputInfo;
        enableSendOrderDish = NO;
    }
    
    if (!self.textFieldVIPNum.text) {
        self.labelVIPNumState.text = InputInfo;
    }
    
    if (!self.textFieldWorkerPassword.text) {
        
        self.labelPasswardState.text = InputInfo;
        enableSendOrderDish = NO;
    }
    
    if (!self.buttonSeatName.currentTitle) {
        self.labelSeatChooseState.text = InputInfo;
        enableSendOrderDish = NO;
    }
    else {
        self.labelSeatChooseState.text = CorrectInfo;
    }
    
    if (![self.labelWorkerNumState.text isEqualToString:CorrectInfo] && !enableSendOrderDish) {
        
        //提示错误
        
    }
    else {
        //其他输入正确
        //验证用户密码的正确性，捎带的将数据整理好
        
        //数据整理
        NSMutableDictionary *dictInfo = [NSMutableDictionary dictionary];
        
        //往下是给OrderTable表中添加的数据
        NSMutableDictionary *dictOrderRecord = [NSMutableDictionary dictionary];
        [dictOrderRecord setObject:_buttonSeatName.currentTitle forKey:@"SeatLocation"];
        
        [dictOrderRecord setObject:self.textFieldVIPNum.text forKey:@"VIPNum"];
        
        //TODO: 总价在这里还没有上传，，，先放着
        [dictOrderRecord setObject:self.sumPrice forKey:@"SumPrice"];
        
//        [dictOrderRecord setObject:self.textFieldWorkerNum.text forKey:@"WorkerNum"];
        
//        [dictOrderRecord setObject:@"OrderRecord" forKey:@"TableName"];
        
        //将数据都装入字典中
//        [dictInfo setObject:arrayHistoryOrder forKey:@"HistoryOrder"];
        [dictInfo setObject:dictOrderRecord forKey:@"OrderRecord"];
        
        //或者说是登录员工账号
        
        [[BmobTool shareBmobManager] bmob_loginUserName:self.textFieldWorkerNum.text withPasswark:self.textFieldWorkerPassword.text withDic:dictInfo withBlock:^(BOOL isSuccess, NSArray *array) {
            
            if (!isSuccess) {
                
                
                self.labelPasswardState.text = ErrorInfo;
            }
            else {
                
                self.labelPasswardState.text = CorrectInfo;
                //成功的话要跳转界面
                FirstViewController *viewControllerFirst = [[FirstViewController alloc] init];
                
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewControllerFirst];
                
                UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
                win.rootViewController = navi;
                
                //在这里将用户及密码存储到本地
                //TODO:使用个人偏好设置存储方式
                //1.获取NSUserDefaults对象
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                //2保存数据
                [defaults setObject:self.textFieldWorkerNum.text forKey:@"workerNum"];
                [defaults setObject:self.textFieldWorkerPassword.text forKey:@"password"];
                //3.强制让数据立刻保存
                [defaults synchronize];
                
                /*
                 我在这里加清空已点订单内容
                 */
                
                AppDelegate *app = [[AppDelegate alloc] init];
                [app clearTable];
                
            }
            
        }];
        
    }
    
    
//    if (enableSendOrderDish) {
//
//        HistoryModel *model = [self getHistoryModel];
//        [OrderTableDao insertDataToRoomRecordTable:model];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"清空" object:nil];
//        [OrderTableDao deleteOrderTable];//清空菜单数据
//        [self dismissViewControllerAnimated:YES completion:nil];
//        NSLog(@"---选了房间---------%@",self.buttonSeatName.currentTitle);
//    }
    
}

- (HistoryModel *)getHistoryModel
{
    HistoryModel *model = [[HistoryModel alloc] init];
    //获取当前日期
    NSDate *date = [NSDate date];
    NSDateFormatter *farmatter = [[NSDateFormatter alloc] init];
    [farmatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [farmatter stringFromDate:date];
    //获取当前时间
    NSDate *time = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH时mm分"];
    NSString *timeStr = [formatter stringFromDate:time];
    model.Hdate = dateStr;
    model.Htime = timeStr;
    model.Hroom = self.buttonSeatName.currentTitle;
    NSLog(@"++++++%@",dateStr);
    return model;
}

//X号按钮
- (IBAction)exitBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textField 代理协议方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 1) {
        
        //???: 这里有个问题就是，不能通过键盘上的删除键来删除已经输入的数字字符了
        NSSet *set = [NSSet setWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0", nil];
//
//        NSString *str = @"^[1-9].?\\d*$";
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SWLF MATCHES %@",string];
//
        return [set containsObject:string];
        
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 2) {
        //VIP输入完成，查询一下服务器中是否有VIP账号
        [[BmobTool shareBmobManager] bmob_queryUserName:_textFieldVIPNum.text withBlock:^(BOOL isSuccess, NSArray *array) {
            
            if (isSuccess) {
                self.labelVIPNumState.text = CorrectInfo;
            }
            else {
                self.labelVIPNumState.text = ErrorInfo;
                
                self.canSendOrder = NO;
            }
            
        }];
        
    }
    
    if (textField.tag == 3) {
        //工号输入完成，查询一下服务器中是否有此工号
        
        [[BmobTool shareBmobManager] bmob_queryUserName:_textFieldWorkerNum.text withBlock:^(BOOL isSuccess, NSArray *array) {
            
            if (isSuccess) {
                self.labelWorkerNumState.text = CorrectInfo;
                
            }
            else {
                self.labelWorkerNumState.text = ErrorInfo;
                
                self.canSendOrder = NO;
            }
            
        }];
        
    }
    
    if (textField.tag == 4) {
        //密码输入完成，如果工号成功的话，验证密码正确性
        
        if ([self.labelWorkerNumState.text isEqualToString:@"YES"]) {
            
            //验证密码
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
