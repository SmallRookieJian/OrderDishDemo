//
//  SettingViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "SettingViewController.h"
//#import "UIImageView+WebCache.h"
#import "FileManager.h"
#import "LoginViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.tableView reloadData];

}


- (void)viewDidLoad {
    [super viewDidLoad];

//    声明一个画板
    CALayer *layer = [[CALayer alloc]init];
//
    layer.frame = CGRectMake(100, 100, 100, 100);

//    layer 是C中的概念  不能直接接受[UIImage imageNamed:@"aaa.jpg"]  这个是oc中的对象
//    需要转换成CGImage 格式才能使用
//    layer.contents 接收的是oc类型的数据

    layer.contents = (id)[UIImage imageNamed:@"aaa.jpg"].CGImage;

    layer.backgroundColor = [UIColor redColor].CGColor;
//域 作用域
    layer.cornerRadius = 50;
    layer.masksToBounds = YES;
    [self.view.layer addSublayer:layer];

    _tableView = [[UITableView alloc]init];
    _tableView.frame = self.view.frame;
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingCell"];
//    [self.view addSubview:self.tableView];

//    [[FileManager sharManager] downLoadFileSize];

}

#pragma mark - 
#pragma mark TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 3;
    }else
    {
        return 1;
    }

}

#pragma  mark -
#pragma  mark  TableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];

    if (indexPath.section ==0) {
        cell.textLabel.text = @"个人信息";
    }else if(indexPath.section == 1)
    {


        if (indexPath.row == 0) {
            //
            NSInteger  size = [[SDImageCache sharedImageCache] getSize];
            //size 显示的是字节数 -- B
            // 1024B= 1k
            //        1024k = 1M
            CGFloat  sizeM= (size/1024.f)/1024.f;
            NSLog(@"1----%f",sizeM);
            cell.textLabel.text = [NSString stringWithFormat:@"清理图片缓存（%.2fM）",sizeM];
        }else if(indexPath.row == 1)
        {
//            文件缓存大小需要我们自己去计算
            NSInteger size = [[FileManager sharManager] downLoadFileSize];
            CGFloat sizeM = (size/1024.f)/1024.f;
            cell.textLabel.text = [NSString  stringWithFormat:@"清理文件缓存（%.2fM）",sizeM];
        }else if(indexPath.row ==2)
        {

                cell.textLabel.text = @"退出登录";
        }

    }else if(indexPath.section == 2)
    {
        cell.textLabel.text = @"关于我们";

    }

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    缺少弹框
    if (indexPath.section == 1) {
        if (indexPath.row ==0) { //图片缓存
            [[SDImageCache sharedImageCache] clearDisk];
//清除缓存后记得要刷新表 tableView也会缓存
//            如果不清楚计算会不准确
            [self.tableView reloadData];

//
        }else if (indexPath.row ==1)//文件缓存
        {
            [[FileManager sharManager] clearDownLoadFile];
            [self.tableView reloadData];


        }else if(indexPath.row == 2)//退出登录
        {

//
//         USER_TOKEN
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            清楚两个内容
            [userDefaults removeObjectForKey:USER_TOKEN];
            [userDefaults synchronize];

            LoginViewController *loginViewController = [LoginViewController new];

            APP_WIN.rootViewController = loginViewController;

        }



    }


}







@end
