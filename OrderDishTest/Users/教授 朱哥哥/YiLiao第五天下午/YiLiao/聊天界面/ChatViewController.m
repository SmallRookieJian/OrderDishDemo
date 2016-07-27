//
//  ChatViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ChatViewController.h"
#import "PeopleCell.h"
#import "PeoInfoViewController.h"
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getFriendList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _peopleArr = [[NSMutableArray alloc] init];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 125;
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"PeopleCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)getFriendList
{
    //获取到朋友列表信息
    [NetworkTool requestFriendListInfo:^(NSDictionary *dic)
     {
         //每次请求好友列表都要将好友数组内容清空,不然好友会重复
        [_peopleArr removeAllObjects];
        NSArray *arr = [dic objectForKey:@"data"];
        for (NSDictionary *peoDic in arr)
        {
            ZYPeople *p = [[ZYPeople alloc] initWithDictionary:peoDic];
            [_peopleArr addObject:p];
        }
        [_tableView reloadData];
    }];
}


#pragma mark -tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _peopleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row==0)
    {
        //自己不显示消息数
        cell.messageLabel.hidden = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZYPeople *p = [_peopleArr objectAtIndex:indexPath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@/st%@",HOST,p.headerUrl];
    
    [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"head.png"]];
    cell.nameLabel.text = p.name;
    cell.tmperLabel.text = @"说说:其实就是一种心情,时好时坏.";
    cell.messageLabel.text = [NSString stringWithFormat:@"%@",@0];
    cell.headerBtn.tag = indexPath.row;
    [cell.headerBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)headerBtnClicked:(UIButton *)btn
{
    ZYPeople *p = [_peopleArr objectAtIndex:btn.tag];
    PeoInfoViewController *vc = [[PeoInfoViewController alloc] init];
    if (btn.tag == 0)
    {
        vc.isSelf = YES;
    }
    else
    {
        vc.isSelf = NO;
    }
    vc.p = p;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}












@end
