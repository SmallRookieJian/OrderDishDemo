//
//  OthersMenuViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "OthersMenuViewController.h"
#import "ChefRecommendDAO.h"
#import "DishModel.h"
#import "FMDB.h"
#import "DetailViewController.h"
#import "MyOrderViewController.h"
#import "OrderTableDao.h"
#import "AppDelegate.h"


@interface OthersMenuViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSArray *_nameArr;
    NSArray *_rowArr;
    NSArray *_arrSet;
    NSInteger _selectedHeaderNum;
    NSIndexPath *_selectedIndexPath;
    NSIndexPath *_indexpath;
    NSMutableArray *_myDishArr;
}
@end

@implementation OthersMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _myDishArr = [ChefRecommendDAO getModelFromDatabase];
    if (!_myDishArr)
    {
        _myDishArr = [[NSMutableArray alloc]init];
    }
    [_table reloadData];
//    _numDish.text =[NSString stringWithFormat:@"%ld",_myDishArr.count];
    [self refreshNumLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteLabelText) name:@"清空" object:nil];
//    NSLog(@"茶牌页面=====%ld",_myDishArr.count);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _indexpath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    _nameArr =[ChefRecommendDAO readHeaderData:self.selectedRow];
    _arrSet = [ChefRecommendDAO readRowData:_nameArr];
    _rowArr = [[NSArray alloc]init];
    _picName.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldicon",_selectedRow+1]];
    _table.delegate =self;
    _table.dataSource = self;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.sectionHeaderHeight = 50;
    _table.backgroundColor = [UIColor clearColor];
    _rowArr = _arrSet[_selectedHeaderNum];
    
//    NSLog(@"我在这里输出数组：%@",_rowArr);
    
    [self createScrollView];
}
- (void)deleteLabelText
{
    _numDish.text = @"0";
}
- (void)createScrollView
{
    _scrollView.contentSize = CGSizeMake(500*_rowArr.count, 513);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    for (int i = 0; i < _rowArr.count; i ++)
    {
        _rowArr = _arrSet[_selectedHeaderNum];
        DishModel *model = _rowArr[i];
        
        NSString *picName = [NSString stringWithFormat:@"%@.jpg",model.name];
//        NSLog(@"++++++这是图片名称%@",picName);
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(500*i, 0, 500, 513)];
        picView.image = [UIImage imageNamed:picName];
        [_scrollView addSubview:picView];
    }

}
#pragma mark - scrollView协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int row = scrollView.contentOffset.x/500;
    _selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:_selectedHeaderNum];
    [_table reloadData];
    NSLog(@"scroll ====%d",row);
}
#pragma mark - tableView 数据源协议的两个必选方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectedHeaderNum == section)
    {
        return _rowArr.count;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (_selectedIndexPath.row == indexPath.row &&_selectedIndexPath.section == indexPath.section)
    {
        if (!(UIImageView *)[cell viewWithTag:1000])
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
            imageView.tag = 1000;
            imageView.image = [UIImage imageNamed:@"line32"];
            [cell addSubview:imageView];
            [UIView transitionWithView:cell duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
//            NSLog(@"YES");
        }
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:1000];
        [imageView removeFromSuperview];
//        NSLog(@"移除成功");
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DishModel *model = _rowArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元/%@",model.price,model.unit];;
    cell.detailTextLabel.textColor = [UIColor yellowColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedIndexPath == indexPath)
    {
        return;
    }
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedIndexPath = indexPath;
    _scrollView.contentOffset = CGPointMake(indexPath.row*500, 0);
    [_table reloadData];
//    [UIView transitionWithView:cell duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"line31"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonCliked:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section;
    
//    NSLog(@"====表的区头数量:%d",_nameArr.count);
    NSString *sectionName = _nameArr[section];
    [button setTitle:sectionName forState:UIControlStateNormal];
    return button;
}
- (void)buttonCliked:(UIButton *)button
{
    if (_selectedHeaderNum == button.tag)
    {
        return;
    }
    for (UIImageView *imageView in _scrollView.subviews)
    {
        [imageView removeFromSuperview];
    }
    _rowArr = _arrSet[button.tag];
     _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:button.tag];
    [_table reloadData];
    _scrollView.contentOffset = CGPointMake(0, 0);
   
    _selectedHeaderNum = button.tag;
    [self createScrollView];
    [_table reloadData];
    
    NSLog(@"点击的区头:%ld=====数组中数量为:%ld",button.tag,_rowArr.count);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _nameArr.count;
}
#pragma mark - 点菜按钮
- (IBAction)OrderDishBtn:(id)sender
{
    
    if (_indexpath == _selectedIndexPath) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此菜已在菜单中,请在菜单中修改信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    _indexpath = _selectedIndexPath;
    DishModel *model = _rowArr[_selectedIndexPath.row];
    [_myDishArr addObject:model];
    [OrderTableDao insertOrderTable:model];
    _myDishArr = [ChefRecommendDAO getModelFromDatabase];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(270, 165, 332, 355)];
    imageView.image = [UIImage imageNamed:model.picName];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:1 animations:^{
        imageView.frame = CGRectMake(150, 700, 0, 0);
        
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
//        _numDish.text =[NSString stringWithFormat:@"%ld",_myDishArr.count];
        [self refreshNumLabel];
    }];
}
#pragma mark - 详细按钮
- (IBAction)detailBtn:(id)sender
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    
    
    //这里需要添加东西
    
    
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark - 我的菜单按钮
- (IBAction)myOrderBtn:(id)sender
{
    MyOrderViewController *vc = [[MyOrderViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vc.myDishArr = nil;
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
    
    _numDish.text =[NSString stringWithFormat:@"%ld",arrayAllOrderDish.count];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
