//
//  DetailViewController.m
//  OrderDishTest
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DetailViewController.h"

#import "DishModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    //TODO:在这里有些问题，怎么这个界面一出现的话，上个界面的数据就消失了呢？
    
    //FIXME:你好啊
    //!!!:好
    //???:我很好
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.backgroundColor = [UIColor grayColor];
    
    imgView.image = [UIImage imageNamed:@"bgp3.png"];
    
    [self.view addSubview:imgView];
    
    [self.view sendSubviewToBack:imgView];
    
    [_detailImgView sd_setImageWithURL:self.model.urlImage];
    _nameLabel.text = self.model.name;
    _nameLabel.textColor = [UIColor whiteColor];
}
- (IBAction)exitBtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
