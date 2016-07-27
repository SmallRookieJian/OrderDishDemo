//
//  DishModel.h
//  OrderDishTest
//
//  Created by mac on 16/2/21.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DishModel : NSObject
@property(nonatomic, copy) NSString *iKind,*name,*price, *unit,*detail,*picName,*groupID,*ID,*num;
@property (nonatomic, strong) NSURL *urlImage;

- (id)initWithDict:(NSDictionary *)dict;

- (NSArray *)modelPropertyNames;

@end
