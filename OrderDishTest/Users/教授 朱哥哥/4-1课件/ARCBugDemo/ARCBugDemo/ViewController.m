//
//  ViewController.m
//  ARCBugDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NewViewController *_nnViewController = [[NewViewController alloc]init];
    _nnViewController = [[NewViewController alloc]init];
    _nnViewController.view.frame = CGRectMake(100, 100, 100, 100);
    _nnViewController.view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:_nnViewController.view];
    
//    [self presentViewController:newViewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
