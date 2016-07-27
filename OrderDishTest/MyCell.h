//
//  MyCell.h
//  OrderDishTest
//
//  Created by mac on 16/2/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTable+CoreDataProperties.h"

@protocol MyCellDelegate <NSObject>

@required

- (void)textFieldContentChanged:(NSString *)num;

@end


@class DishModel;

@interface MyCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelID;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelIKind;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNum;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDetail;


@property (nonatomic, strong) OrderTable *model;
@property (nonatomic, assign) NSInteger index;


@property (nonatomic, assign) id<MyCellDelegate>delegate;

@end
