//
//  ChefRecommendDAO.h
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DishModel;
@interface ChefRecommendDAO : NSObject

+ (NSArray *)readHeaderData:(NSInteger)rightRowID;
+ (NSArray *)readRowData:(NSArray *)array;
+ (NSMutableArray *)getModelFromDatabase;

@end
