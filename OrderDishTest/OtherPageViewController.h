//
//  OtherPageViewController.h
//  OrderDishTest
//
//  Created by mac on 2016/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherPageViewController : UIViewController


@property (nonatomic, strong) NSArray *arrayTableHeaderNames;
@property (nonatomic, strong) NSURL *urlPageTitleImage;



@property (weak, nonatomic) IBOutlet UIImageView *imgViewPageTitleImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
