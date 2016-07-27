//
//  ChefRecommendViewController.h
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChefRecommendViewController : UIViewController
{
    __weak IBOutlet UITableView *_table;

    __weak IBOutlet UIScrollView *_scrollView;

    __weak IBOutlet UILabel *_numLabel;
}

@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, strong) NSArray *arrayTableHeaderNames;

@end
