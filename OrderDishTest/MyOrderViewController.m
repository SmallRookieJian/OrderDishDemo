//
//  MyOrderViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyCell.h"
#import "DishModel.h"
#import "DishSeatViewController.h"
#import "ChefRecommendDAO.h"
#import "OrderTableDao.h"


#import "AppDelegate.h"
#import "OrderTable+CoreDataProperties.h"

@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,MyCellDelegate>

@property(nonatomic, strong) NSMutableArray *arrAllOrderDish;

@property (weak, nonatomic) IBOutlet UILabel *labelSumPrice;

@end

@implementation MyOrderViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self queryAllOrderedDishInfo];
    
    [_table reloadData];
    
}

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
    
    _arrAllOrderDish = [NSMutableArray array];
    
    [_table registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _table.backgroundColor = [UIColor clearColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationQueryOrderTable:) name:@"重新查询" object:nil];
    
}

//- (void)notificationQueryOrderTable:(NSNotification *)noti {
//    
//    NSLog(@"notification %@",noti);
//    
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrAllOrderDish.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.delegate = self;
    
    OrderTable *model = self.arrAllOrderDish[indexPath.row];
    
    cell.model = model;

    cell.index = indexPath.row + 1;
    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
}

//X号 按钮
- (IBAction)exitBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 送单按钮
- (IBAction)sendDishOrderBtn:(id)sender
{
    NSInteger sumPrice = [self.labelSumPrice.text integerValue];
    NSNumber *numSumPrice = [NSNumber numberWithInteger:sumPrice];
    
    DishSeatViewController *vc = [[DishSeatViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //将总价传递过去
    vc.sumPrice = numSumPrice;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - MyCellDelegate 实现方法

- (void)textFieldContentChanged:(NSString *)num {
    
    [self queryAllOrderedDishInfo];
    
}

#pragma mark - 计算总价并且更改label显示

- (void)caculateAndShowSumPrice {
    
    NSInteger sumPrice = 0;
    
    for (OrderTable *model in self.arrAllOrderDish) {
        
        NSInteger num = [model.num integerValue];
        NSInteger price = [model.price integerValue];
        
        sumPrice += num*price;
        
    }
    
    self.labelSumPrice.text = [NSString stringWithFormat:@"%ld",sumPrice];
    
}

#pragma mark - 查询（更新）已点菜品的具体信息

- (void)queryAllOrderedDishInfo {
    
    AppDelegate *appd = [[AppDelegate alloc] init];
    
    NSArray *arrayAllOrderDish = [appd selectEntity:@"OrderTable" withPrediacte:nil];
    
    [self.arrAllOrderDish removeAllObjects];
    
    [self.arrAllOrderDish addObjectsFromArray:arrayAllOrderDish];
//    NSLog(@"query all ordered dish %@",self.arrAllOrderDish);
    [self caculateAndShowSumPrice];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
