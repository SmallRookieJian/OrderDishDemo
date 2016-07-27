//
//  RightViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "RightViewController.h"
#import "ChefRecommendViewController.h"
#import "OthersMenuViewController.h"
#import "FMDB.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "BmobTool.h"
#import "RightTableViewCell.h"
#import "ButtonPageModel.h"
#import "OtherPageViewController.h"

@interface RightViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    NSInteger _selectedRow;
    
    NSMutableArray *_arrBtnPageModels;

}

@property(nonatomic, strong) UIViewController *leftViewController;

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _table.delegate = self;
    _table.dataSource = self;
    
    _arrBtnPageModels = [NSMutableArray array];
    
    [_table registerClass:[RightTableViewCell class] forCellReuseIdentifier:@"cell"];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight = 107;
    _table.showsVerticalScrollIndicator = NO;
    _table.backgroundColor = [UIColor clearColor];
    
    _leftViewController = [[ChefRecommendViewController alloc] init];
    
    [self.view addSubview:_leftViewController.view];
    [self.view bringSubviewToFront:_table];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [[BmobTool shareBmobManager] bmob_queryWithBQLTableName:@"groupTable" withBock:^(BOOL isSuccess, NSArray *array) {
        
        if (!isSuccess) {
            NSLog(@"RightViewController ------ 请求不成功");
        }
        
        [_arrBtnPageModels addObjectsFromArray:array];
        
        [_table reloadData];
        
        ChefRecommendViewController *recomendViewController = [[ChefRecommendViewController alloc] init];
        
        ButtonPageModel *btnPageModel = _arrBtnPageModels[0];
        
        recomendViewController.arrayTableHeaderNames = btnPageModel.arrTableHeaderNames;
        
        self.leftViewController = recomendViewController;
        
        [self.view addSubview:recomendViewController.view];
        [self.view bringSubviewToFront:_table];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%ld",_arrBtnPageModels.count);
    return _arrBtnPageModels.count;
//    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ButtonPageModel *btnPageModel = _arrBtnPageModels[indexPath.row];
    
    if ( indexPath.row == _selectedRow)
    {
        cell.urlImage = btnPageModel.urlHImage;
    }
    else
    {
        cell.urlImage = btnPageModel.urlImage;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedRow == indexPath.row)
    {
        return;
    }
    _selectedRow = indexPath.row;
    [_table reloadData];
    
    ButtonPageModel *btnPageModel = _arrBtnPageModels[indexPath.row];
    
    if (indexPath.row == 0)
    {
        [self.leftViewController.view removeFromSuperview];//先移除旧的视图在添加一个新的 防止视图堆积过多 占用内存
        ChefRecommendViewController *vc = [[ChefRecommendViewController alloc] init];
        self.leftViewController = vc;
        vc.selectedRow = indexPath.row;
        
        //TODO: 在这里也是一个技术点
        
        vc.arrayTableHeaderNames = btnPageModel.arrTableHeaderNames;
        
        [self.view addSubview:vc.view];
    }
    else
    {
        
        [self.leftViewController.view removeFromSuperview];
        OthersMenuViewController *vc = [[OthersMenuViewController alloc] init];
        
        vc.selectedRow = indexPath.row;
        vc.arrayTableHeaderNames = btnPageModel.arrTableHeaderNames;
//        NSLog(@"这是我要发送的数%@",btnPageModel.arrTableHeaderNames);
        self.leftViewController = vc;
        
        [self.view addSubview:vc.view];
    }
    
    [self.view bringSubviewToFront:_table];

//    NSLog(@"======%d",_selectedRow);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
