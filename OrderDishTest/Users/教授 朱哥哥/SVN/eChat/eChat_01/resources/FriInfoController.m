//
//  FriInfoController.m
//  eChat_01
//
//  Created by mac on 2016/3/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FriInfoController.h"

@interface FriInfoController ()

@end

@implementation FriInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //在这里把有导航键给去掉
    self.navigationItem.rightBarButtonItem = nil;
    
    
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
