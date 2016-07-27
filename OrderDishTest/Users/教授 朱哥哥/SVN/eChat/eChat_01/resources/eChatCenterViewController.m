//
//  eChatCenterViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "eChatCenterViewController.h"
#import "FriendListCell.h"

#import "UserInfoRequest.h"
#import "PersonalInfoModel.h"
#import "PerInfoViewController.h"
#import "FriInfoController.h"

#import "UIImageView+WebCache.h"
@interface eChatCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_arrayFriendsList;
    
}
@end

@implementation eChatCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天中心";
    
    [self configurateTableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UserInfoRequest gainFrinedsList:^(NSArray *arrFriends) {
        
        _arrayFriendsList = arrFriends;
//        NSLog(@"%@",_arrayFriendsList);
        
        [_tableView reloadData];
        
    }];
    
}

- (void)configurateTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"FriendListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark 表的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayFriendsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    PersonalInfoModel *model = _arrayFriendsList[indexPath.row];
    
    cell.labelName.text = model.name;
    cell.labelText.text = @"说说：其实就是一个心情，时好时坏";
    
    if ([model.headerURL isEqualToString:@"null"]) {
//        NSLog(@"%@",model.headerURL);
        cell.imgViewHeader.image = [UIImage imageNamed:@"head.png"];
        
    }
    else {
//        NSLog(@"%@",model.headerURL);
        [cell.imgViewHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/ycs%@",model.headerURL]]];
        
    }
    
    if (indexPath.row == 0) {
        
        cell.labelMessageNum.hidden = YES;
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        PerInfoViewController *vcPerInfo = [[PerInfoViewController alloc] init];
        vcPerInfo.model = _arrayFriendsList[indexPath.row];
        [self.navigationController pushViewController:vcPerInfo animated:YES];
    }
    else {
        
        FriInfoController *vcFriInfo = [[FriInfoController alloc] init];
        vcFriInfo.model = _arrayFriendsList[indexPath.row];
        [self.navigationController pushViewController:vcFriInfo animated:YES];
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 107;
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
