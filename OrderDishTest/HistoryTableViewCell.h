//
//  HistoryTableViewCell.h
//  OrderDishTest
//
//  Created by mac on 16/2/26.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryModel;
@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *roomLab;
@property (weak, nonatomic) IBOutlet UIButton *queryBtn;

@property (nonatomic, strong) HistoryModel *model;

- (void)setModel:(HistoryModel *)model;

@end
