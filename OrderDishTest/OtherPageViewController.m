//
//  OtherPageViewController.m
//  OrderDishTest
//
//  Created by mac on 2016/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OtherPageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface OtherPageViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@end

@implementation OtherPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurateUserInterface];
    
    
}


- (void)configurateUserInterface {
    
    [self configurateTableView];
    [self configurateScrollView];
    [self configuratePageTitleImage];
    
}

- (void)configuratePageTitleImage {
    
    self.imgViewPageTitleImage.backgroundColor = [UIColor cyanColor];
    [self.imgViewPageTitleImage sd_setImageWithURL:self.urlPageTitleImage];
}
#pragma mark ---
#pragma mark 配置tableView 及代理协议方法
- (void)configurateTableView {
    
    self.tableView.backgroundColor = [UIColor yellowColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"你好啊";
    
//    NSLog(@"你走了么？");
    
    return cell;
}

#pragma mark -- 
#pragma mark 配置scrollView 及代理协议方法
- (void)configurateScrollView {
    
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.delegate = self;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"我拖动停止了");
    
}

- (IBAction)btnOrderDishClicked:(id)sender {
    NSLog(@"我要点菜了");
}

- (IBAction)btnDetailClicked:(id)sender {
    NSLog(@"详情界面");
}

- (IBAction)btnMyOrderClicked:(id)sender {
    NSLog(@"我的菜单");
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
