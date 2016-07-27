//
//  SeatViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SeatViewController.h"

@interface SeatViewController ()

@end

@implementation SeatViewController

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
//文华轩
- (IBAction)wenhuaxuanBtn:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:self userInfo:@{@"名字":@"文华轩"}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//希尔顿
- (IBAction)xierdunBtn:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:self userInfo:@{@"名字":@"希尔顿"}];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//威斯汀
- (IBAction)weisitingBtn:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:self userInfo:@{@"名字":@"威斯汀"}];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
