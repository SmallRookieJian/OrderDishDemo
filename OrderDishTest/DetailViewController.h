//
//  DetailViewController.h
//  OrderDishTest
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DishModel;

@interface DetailViewController : UIViewController
{
    
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UIImageView *_detailImgView;
}

@property (nonatomic, strong) DishModel *model;

@end
