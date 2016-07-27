//
//  MMMMViewController.m
//  OrderDishTest
//
//  Created by mac on 2016/4/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MMMMViewController.h"

@interface MMMMViewController ()

@end

@implementation MMMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50,50, 100, 30);
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)btnClicked {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
