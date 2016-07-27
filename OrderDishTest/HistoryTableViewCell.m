//
//  HistoryTableViewCell.m
//  OrderDishTest
//
//  Created by mac on 16/2/26.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "HistoryModel.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setModel:(HistoryModel *)model {
    
    _dateLab.text = model.Hdate;
    _timeLab.text = model.Htime;
    _roomLab.text = model.seatLocation;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
