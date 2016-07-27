//
//  FileImageModel.m
//  eChat_01
//
//  Created by mac on 2016/3/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FileImageModel.h"

@implementation FileImageModel
+ (FileImageModel *)parserFromDic:(NSDictionary *)dic {
    return [[self alloc] initFromDic:dic];
}
- (id)initFromDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.width = [[dic objectForKey:@"width"] intValue];
        self.height = [[dic objectForKey:@"width"] intValue];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"width:%d\nheight:%d",self.width,self.height];
}

@end
