//
//  HistoryModel.m
//  OrderDishTest
//
//  Created by mac on 16/2/26.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "HistoryModel.h"
#import <BmobSDK/BmobObject.h>

#import "objc/runtime.h"

@implementation HistoryModel

- (id)initWithObject:(BmobObject *)object {
    
    self = [super init];
    if (self) {
        NSMutableArray *allNames = [NSMutableArray array];
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList([object class], &propertyCount);
        
        for (int i = 0; i < propertyCount; i ++) {
            ///取出第一个属性
            objc_property_t property = propertys[i];
            
            const char * propertyName = property_getName(property);
            
            [allNames addObject:[NSString stringWithUTF8String:propertyName]];
        }
        
        free(propertys);
        NSLog(@"%@",[[object valueForKey:@"bmobDataDic"] class]);
        
        NSLog(@"%@",allNames);
        
        NSDictionary *dicPropertys = [object valueForKey:@"bmobDataDic"];
                
        _orderID = [dicPropertys valueForKey:@"OrderID"];
        _sumPrice = [dicPropertys valueForKey:@"SumPrice"];
        _vipNum = [dicPropertys valueForKey:@"VIPNum"];
        _seatLocation = [dicPropertys valueForKey:@"SeatLocation"];
        /*
         *orderID,*sumPrice;
         *seatLocation,*vipNum,*workerName
         */
        _date = [object valueForKey:@"createdAt"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //用[NSDate date]可以获取系统当前时间
        NSString *strDate = [dateFormatter stringFromDate:self.date];
//        NSString *strTime =
        //输出格式为：2010-10-27 10:22:13
        NSLog(@"%@",strDate);
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"HH:mm:ss"];
        NSString *strTime = [timeFormatter stringFromDate:self.date];
        NSLog(@"%@",strTime);
        
        _Hdate = strDate;
        _Htime = strTime;
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"这里是OrderRecord的属性值%@,%@,%@,%@,日期%@,%@",self.orderID,self.sumPrice,self.vipNum,self.seatLocation,self.Hdate,self.Htime];
}

@end
