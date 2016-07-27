//
//  FMDB.h
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface FMDB : NSObject

+ (FMDatabase *)getDataBase;
+ (void)copyDatabaseToSandBox;


@end
