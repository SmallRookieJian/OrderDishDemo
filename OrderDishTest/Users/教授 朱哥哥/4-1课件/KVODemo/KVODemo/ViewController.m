//
//  ViewController.m
//  KVODemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "ViewController.h"
#import "SettingViewController.h"
#import "ColorManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 64, 44);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    Xcode 编译时特性
//    只有在运行的时候会检测属性内存是否存在
    
    [[ColorManager sharManager] addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionNew context:nil];
    
//    [self addObserver:self forKeyPath:@"要监测的对象" options:NSKeyValueObservingOptionNew context:nil];
//    [self removeObserver:self forKeyPath:@"要删除的监测对象"];
    
}

-(void)buttonTouched:(id)send
{
    SettingViewController *settingViewController = [[SettingViewController alloc]init];
    
    [self presentViewController:settingViewController animated:YES completion:nil];
    
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    如果kvo监测到数据了 这里肯定可以响应
    NSLog(@"---dict == %@",change);
    
    UIColor *myColor = [change valueForKey:@"new"];
    
    self.view.backgroundColor = myColor;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
