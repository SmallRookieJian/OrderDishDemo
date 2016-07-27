//
//  ColorManager.m
//  KVODemo
//
//  Created by LiuTao on 16/4/1.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager


+(instancetype)sharManager
{
    static ColorManager *manager;
    
//    if (!manager) {
//        manager = [[ColorManager alloc]init];
//    }
//    return manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ColorManager alloc]init];
    });
    return manager;
    
}













@end
