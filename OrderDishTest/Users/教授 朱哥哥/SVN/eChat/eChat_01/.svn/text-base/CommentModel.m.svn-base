//
//  CommentModel.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (CommentModel *)parserWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        self.name = [dic objectForKey:@"name"];
        self.info = [dic objectForKey:@"info"];
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"name.....%@\ninfo.....%@",self.name,self.info];
}

@end
