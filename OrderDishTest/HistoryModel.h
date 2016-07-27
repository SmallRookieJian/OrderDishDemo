//
//  HistoryModel.h
//  OrderDishTest
//
//  Created by mac on 16/2/26.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;
@interface HistoryModel : NSObject

@property (nonatomic,copy)NSString *Hdate,*Htime,*HrowID,*Hroom;
@property (nonatomic, strong) NSNumber *orderID,*sumPrice;
@property (nonatomic, copy) NSString *seatLocation,*vipNum,*workerName;
@property (nonatomic, strong) NSDate *date;


- (id)initWithObject:(BmobObject *)object;

@end
