//
//  IndividualCenterViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "IndividualCenterViewController.h"
#import "PeopleMainCell.h"
#import "UserInfoRequest.h"
#import "PerInfoViewController.h"


#import "UIImageView+WebCache.h"


@interface IndividualCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSArray *_array;
    PersonalInfoModel *_modelPerInfo;
}
@end

@implementation IndividualCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self configurateTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UserInfoRequest obtainPersonalInfo:^(PersonalInfoModel *model) {
        
//        NSLog(@"%@",model);
        _modelPerInfo = model;
        
        [_tableView reloadData];
        
    }];
}

- (void)configurateTableView {
    
    _array = @[@"清理图片缓存",@"清理文件缓存",@"退出登录"];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"PeopleMainCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark 表的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if(section == 1) {
        return 3;
    }
    else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleMainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (indexPath.section == 0) {
        cell.labelText.text = @"个人信息";
        [cell.imgViewHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/ycs%@",_modelPerInfo.headerURL]]];
    }
    if (indexPath.section == 1) {
        cell.labelText.frame = CGRectMake(5, 10, 170, 40);
        cell.labelText.text = _array[indexPath.row];
        
    }
    if (indexPath.section == 2) {
        cell.labelText.text = @"关于我们";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    else if (indexPath.section == 1) {
        return 50;
    }
    else if (indexPath.section == 2) {
        return 50;
    }
    else {
        return 90;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //点击的地方在第0区的话，直接跳转到PerInfoViewController 页面
        PerInfoViewController *vcPerInfo = [[PerInfoViewController alloc] init];
        vcPerInfo.model = _modelPerInfo;
        [self.navigationController pushViewController:vcPerInfo animated:YES];
        
    }
    if (indexPath.section == 2) {
        
        NSString *title = @"温馨提示";
        NSString *message = @"ZYYiChat是一款集聊天，新闻，娱乐为一体的软件，欢迎各位的使用！在使用过程中如果有什么问题可以联系我们。\nTEL:0371-88888598\nEmail:zhiyou3g@163.com";
        NSString *actionTitle = @"我知道了!";
        [self configurateAlertControllerWithTitle:title WithMessage:message WithActionTitle:actionTitle];
    }
    
}

- (void)configurateAlertControllerWithTitle:(NSString *)title WithMessage:(NSString *)message WithActionTitle:(NSString *)actionTitle {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
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
