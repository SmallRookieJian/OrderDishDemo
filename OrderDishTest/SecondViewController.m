//
//  SecondViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "RightViewController.h"
#import "PushTool.h"
#import "HistoryOrderViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

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
}
//中文 按钮
- (IBAction)chineseBtn:(id)sender
{
    RightViewController *vc = [[RightViewController alloc] init];
    [PushTool goToNextVC:vc];
    
}
//English 按钮
- (IBAction)englishBtn:(id)sender
{
    
}
//返回 按钮
- (IBAction)backBtn:(id)sender
{
    FirstViewController *vc = [[FirstViewController alloc]init];
    [PushTool goToNextVC:vc];
}
//历史菜单 按钮
- (IBAction)historyBtn:(id)sender
{
    HistoryOrderViewController *vc = [[HistoryOrderViewController alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
