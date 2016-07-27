//
//  OrderTable+CoreDataProperties.h
//  OrderDishTest
//
//  Created by mac on 2016/4/10.
//  Copyright © 2016年 mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "OrderTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderTable (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *iKind;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *num;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSNumber *orderID;

@end

NS_ASSUME_NONNULL_END
