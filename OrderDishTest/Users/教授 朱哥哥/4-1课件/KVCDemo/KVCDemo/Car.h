//
//  Car.h
//  KVCDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    NSString* _name;

}
@property (nonatomic,copy) NSString *color;
@property (nonatomic)NSInteger price;



@end
