//
//  ChefRecommendViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ChefRecommendViewController.h"

#import "DishModel.h"

#import "MyOrderViewController.h"
#import "DetailViewController.h"
#import "SecondViewController.h"

#import "BmobTool.h"

#import "PushTool.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"


@interface ChefRecommendViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) NSMutableArray *arrayTableInfos;

@property (nonatomic, strong) NSMutableArray *arrayAllOrderDish;

@end

@implementation ChefRecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [_table reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteLabelText) name:@"清空" object:nil];
    
    
    [[BmobTool shareBmobManager] bmob_queryWithTableName:@"menuTable" withGroupID:self.selectedRow+1 withBlock:^(BOOL isSuccess, NSArray *array) {
       
        [self.arrayTableInfos removeAllObjects];
        
        for (NSString *name in self.arrayTableHeaderNames) {
            
            NSMutableArray *arraySub = [NSMutableArray array];
            
            for (DishModel *model in array) {
                
                if ([model.iKind isEqualToString:name]) {
                    
                    [arraySub addObject:model];
                    
                }
                
            }
            
            [self.arrayTableInfos addObject:arraySub];
            
        }
        
        [_table reloadData];
        [self createScrollView];
    }];
    
    //刷新已点餐品数量
    [self refreshNumLabel];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrayTableInfos = [NSMutableArray array];
    _arrayAllOrderDish = [NSMutableArray array];
    
    _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    NSLog(@"--%d---",self.selectedIndexPath.section);
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor clearColor];
    _table.sectionHeaderHeight = 50;
    
//scrollView
    
}
- (void)deleteLabelText
{
    _numLabel.text = @"0";
}

- (void)createScrollView
{
    /*
     while
     
     */
    
    if (self.arrayTableInfos.count == 0) {
        return;
    }
    
//    _scrollView.backgroundColor = [UIColor cyanColor];
    NSArray *array = self.arrayTableInfos[self.selectedIndexPath.section];
    
    _scrollView.contentSize = CGSizeMake(1024*array.count, 768);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        DishModel *model = obj;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(1024*idx, 0, 1024, 768)];
        
        [imgView sd_setImageWithURL:model.urlImage];
        
        [_scrollView addSubview:imgView];
        
    }];
    
}

#pragma mark - scrollView协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int row = scrollView.contentOffset.x/1024;
    
    if (row == self.selectedIndexPath.row) {
        return;
    }
    
    _selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:self.selectedIndexPath.section];
    
    [_table reloadData];
    NSLog(@"scroll ====%d",row);
}
#pragma mark - tableView 数据源协议的方法

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayTableInfos.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"--%d----%d",self.selectedIndexPath.section,section);
    if (self.selectedIndexPath.section == section) {
        NSArray *array = self.arrayTableInfos[section];
        return array.count;
    }
    else {
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //这一段是cell翻转动画
    if (_selectedIndexPath.row == indexPath.row &&_selectedIndexPath.section == indexPath.section)
    {
        if (!(UIImageView *)[cell viewWithTag:100])
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
            imageView.tag = 100;
            imageView.image = [UIImage imageNamed:@"line32"];
            [cell addSubview:imageView];
            [UIView transitionWithView:cell duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
        }
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        [imageView removeFromSuperview];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    NSArray *array = self.arrayTableInfos[indexPath.section];
    
    DishModel *model = array[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元/%@",model.price,model.unit];;
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.selectedIndexPath.row == indexPath.row) {
        return;
    }
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    
    [_scrollView setContentOffset:CGPointMake(1024*indexPath.row, 0) animated:YES];
    
    [_table reloadData];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"line31"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section;
    NSString *sectionName = self.arrayTableHeaderNames[section];
    [button setTitle:sectionName forState:UIControlStateNormal];
    return button;
}

- (void)buttonCliked:(UIButton *)button
{
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:button.tag];
    [_table reloadData];
    
}

#pragma mark - 返回按钮
- (IBAction)backBtn:(id)sender
{
    SecondViewController *vc = [[SecondViewController alloc]init];
    [PushTool goToNextVC:vc];
}

#pragma mark - 点菜按钮
- (IBAction)OrderBtn:(id)sender
{
    //在点菜这里我计划使用数据库
    //是使用sqlite 还是 使用 CoreData 呢？ 有待商榷啊，，，要不试试CoreData?
    //好的!
    
    //1.先确定点击的数据是不是能得到
    
    NSArray *array = self.arrayTableInfos[self.selectedIndexPath.section];
    DishModel *model = array[self.selectedIndexPath.row];
    
    NSLog(@"%@",model);
    
    //菜名  单价  种类  份数  备注  还得在界面上增加一个删除按钮
    
    NSString *name = model.name;
    NSString *price = [NSString stringWithFormat:@"%@",model.price];
    NSString *iKind = model.iKind;
    
    NSDictionary *dictOrderDishInfo = @{@"name":name,@"price":price,@"iKind":iKind,@"num":@"1",@"detail":@"空"};
    
    [[[AppDelegate alloc] init] increaseNewOrderDish:@"OrderTable" withInfo:dictOrderDishInfo];
    
    [self refreshNumLabel];
    
}

#pragma mark - 详细按钮
- (IBAction)detailBtn:(id)sender
{
    NSLog(@"你走啊");
    NSArray *array = self.arrayTableInfos[self.selectedIndexPath.section];
    DishModel *model = array[self.selectedIndexPath.row];
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    
    vc.model = model;
    
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma makr - 我的菜单
- (IBAction)MyOrderBtn:(id)sender
{
    //少年不识愁滋味，爱上层楼。爱上层楼，为赋新词强说愁。
    //而今识得愁滋味，欲说还休。欲说还休，却道天凉好个秋。
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.arrAllOrderDish = self.arrayAllOrderDish;
    [self presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark --
#pragma mark 刷新已点餐品数量显示
- (void)refreshNumLabel {
    
    //在这里要做的事情是
    
    //1.先在数据库中查询，已经点了多少的菜品
    
    AppDelegate *appd = [[AppDelegate alloc] init];
    
    NSArray *arrayAllOrderDish = [appd selectEntity:@"OrderTable" withPrediacte:nil];
    
    //呵呵呵，在这里我可以的到已经点了的菜品的信息，然后传到下一页
    
    //2.统计数量，然后显示出来
    
    _numLabel.text =[NSString stringWithFormat:@"%ld",arrayAllOrderDish.count];
    
//    [self.arrayAllOrderDish removeAllObjects];
//
//    [self.arrayAllOrderDish addObjectsFromArray:arrayAllOrderDish];
//    
//    NSLog(@"chef  refrshNumLabel  %@",self.arrayAllOrderDish);
    
//    [self.arrayAllOrderDish addObjectsFromArray:[appd changeModelFromManagerObjectToDishModel:arrayAllOrderDish]];
//    
//    NSLog(@"chef ---- refresh num label ---- %@",self.arrayAllOrderDish);
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
