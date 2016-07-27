//
//  HistoryOrderViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/26.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "HistoryOrderViewController.h"
#import "HistoryTableViewCell.h"
#import "OrderTableDao.h"
#import "HistoryModel.h"
#import "BmobTool.h"
@interface HistoryOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_historyArr;
    __weak IBOutlet UITableView *_table;
}
@end

@implementation HistoryOrderViewController

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
    // Do any additional setup after loading the view from its nib.
    [_table registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    _historyArr = [OrderTableDao queryRoomRecordTable];
    
    _historyArr = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    BmobTool *bmobManager = [BmobTool shareBmobManager];
    [bmobManager bmob_queryWithBQLTableName:@"OrderRecord" withBock:^(BOOL isSuccess, NSArray *array) {
       
        [_historyArr addObjectsFromArray:array];
        
        [_table reloadData];
        
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HistoryModel *model = _historyArr[indexPath.row];
    
    cell.model = model;
    return cell ;
}
- (void)deleteBtnClicked:(UIButton *)button
{
    [OrderTableDao deleteSelectedRowFromRoomRecordTable:button.tag];
    _historyArr = [OrderTableDao queryRoomRecordTable];
    [_table reloadData];
}
//清空按钮
- (IBAction)clearBtn:(id)sender
{
    [OrderTableDao deleteAllDataFromRoomRecordTable];
    _historyArr = [OrderTableDao queryRoomRecordTable];
    [_table reloadData];
}
//关闭按钮
- (IBAction)dismissBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
