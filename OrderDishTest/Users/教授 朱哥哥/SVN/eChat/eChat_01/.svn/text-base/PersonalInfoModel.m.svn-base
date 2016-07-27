//
//  PersonalInfoModel.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PersonalInfoModel.h"

@implementation PersonalInfoModel
+ (PersonalInfoModel *)parserWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        self.name = [dic objectForKey:@"name"];
        self.nickname = [dic objectForKey:@"nickname"];
        self.email = [dic objectForKey:@"email"];
        self.headerURL = [dic objectForKey:@"headerurl"];
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name____%@\nnickname____%@\nemail____%@\nheaderURL____%@",self.name,self.nickname,self.email,self.headerURL];
}

@end
