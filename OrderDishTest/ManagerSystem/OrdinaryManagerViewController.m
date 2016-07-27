//
//  OrdinaryManagerViewController.m
//  OrderDishTest
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OrdinaryManagerViewController.h"

@interface OrdinaryManagerViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;



@end

@implementation OrdinaryManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bmob.cn/app/browser/81517/213834"]];
    [self.webView loadRequest:request];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(refreshWebPage) userInfo:nil repeats:YES];
    [timer fire];
    
//    [self performSelector:@selector(refreshWebPage) withObject:nil afterDelay:1];
    
}

- (void)refreshWebPage {
    
    [self.webView reload];
    
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
