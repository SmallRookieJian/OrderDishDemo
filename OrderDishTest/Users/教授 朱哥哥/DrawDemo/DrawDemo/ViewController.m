//
//  ViewController.m
//  DrawDemo
//
//  Created by 邓鹏飞 on 16/3/31.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _drawView = [[DrawView alloc]init];
    _drawView.frame = self.view.frame;
    _drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
