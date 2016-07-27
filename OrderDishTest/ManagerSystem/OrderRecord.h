//
//  OrderRecord.h
//  OrderDishTest
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;
@interface OrderRecord : NSObject

@property (nonatomic, strong) NSNumber *orderID;
@property (nonatomic, strong) NSString *seatLocation;
@property (nonatomic, strong) NSString *vipNum;
@property (nonatomic, strong) NSNumber *sumPrice;
@property (nonatomic, strong) NSString *workerName;

//+ (id)initWithObject:(BmobObject *object);

@end
