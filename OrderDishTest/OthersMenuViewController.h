//
//  OthersMenuViewController.h
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OthersMenuViewController : UIViewController
{
    __weak IBOutlet UIImageView *_picName;

    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UITableView *_table;
    
    __weak IBOutlet UILabel *_numDish;
}
@property (nonatomic, assign) NSInteger selectedRow;
@property (weak, nonatomic) IBOutlet UIImageView *DishPic;

@property (nonatomic, strong) NSArray *arrayTableHeaderNames;

@end
