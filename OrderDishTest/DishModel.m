//
//  DishModel.m
//  OrderDishTest
//
//  Created by mac on 16/2/21.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DishModel.h"

#import <BmobSDK/bmobFile.h>

@implementation DishModel

//*iKind,*name,*price, *unit,*detail, *picName, *groupID,*ID,*num;

- (id)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        
        _iKind = [dict objectForKey:@"iKind"];
        _name = [dict objectForKey:@"name"];
        _price = [dict objectForKey:@"price"];
        _unit = [dict objectForKey:@"unit"];
        
        _ID = [dict objectForKey:@"id"];
        
        
        BmobFile *file = [dict objectForKey:@"picName"];
        _urlImage = [NSURL URLWithString:file.url];
        
    }
    
    return self;
}
//*iKind,*name,*price, *unit,*detail, *picName, *groupID,*ID,*num;
- (NSArray *)modelPropertyNames {
    return @[@"iKind",@"name",@"price",@"unit",@"detail",@"groupID",@"ID",@"num"];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.name,self.price,self.unit,self.urlImage];
}

@end
