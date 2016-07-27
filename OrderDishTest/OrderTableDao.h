//
//  OrderTableDao.h
//  OrderDishTest
//
//  Created by mac on 16/2/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DishModel.h"
#import "HistoryModel.h"
@interface OrderTableDao : NSObject

+ (void)insertOrderTable:(DishModel *)model;

+ (void)deleteOrderTable;

+ (NSString *)countSum;

+ (void)insertDataToRoomRecordTable:(HistoryModel *)model;
+ (NSMutableArray *)queryRoomRecordTable;
+ (void)deleteSelectedRowFromRoomRecordTable:(NSInteger)rowID;

+ (void)deleteAllDataFromRoomRecordTable;
@end
