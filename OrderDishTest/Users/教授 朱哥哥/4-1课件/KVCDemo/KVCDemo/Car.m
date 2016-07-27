//
//  Car.m
//  KVCDemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "Car.h"

@implementation Car

-(id)init
{
    if (self = [super init]) {
        
        _name = @"BMW";
        _price = 10;
        _color = @"red";
    }

    return self;
}


@end
