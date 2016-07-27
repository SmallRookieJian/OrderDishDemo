//
//  ZYPeople.m
//  YiLiao
//
//  Created by MrCheng on 16/3/18.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ZYPeople.h"

@implementation ZYPeople

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"name"];
        self.nickName = [dic objectForKey:@"nickname"];
        self.email = [dic objectForKey:@"email"];
        self.headerUrl = [dic objectForKey:@"headerurl"];
    }
    return self;
}



@end
