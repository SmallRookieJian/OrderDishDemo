//
//  SettingViewController.m
//  KVODemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "SettingViewController.h"
#import "ColorManager.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 64, 44);
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    UIButton *buttonColorSet =[UIButton buttonWithType:UIButtonTypeCustom];
    buttonColorSet.frame = CGRectMake(150, 20, 120, 44);
    buttonColorSet.backgroundColor = [UIColor blueColor];
    [buttonColorSet setTitle:@"改变颜色" forState:UIControlStateNormal];
    [buttonColorSet addTarget:self action:@selector(setNewColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonColorSet];

}

-(void)buttonTouched:(id)send
{
    [self dismissViewControllerAnimated:YES completion:nil];


}

-(void)setNewColor:(id)send
{
    [ColorManager sharManager].color = [UIColor cyanColor];

}














@end
