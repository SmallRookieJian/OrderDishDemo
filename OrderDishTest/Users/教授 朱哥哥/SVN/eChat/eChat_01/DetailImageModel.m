//
//  DetailImageModel.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DetailImageModel.h"

@implementation DetailImageModel

+ (DetailImageModel *)parserWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
    
}
- (id)initWithDic:(NSDictionary *)dic {
    /*
     int width,height;
     @property (nonatomic, copy) NSString *url;
     
     */
    
    self = [super init];
    if (self) {
        
        self.width = [[dic objectForKey:@"width"] intValue];
        self.height = [[dic objectForKey:@"height"] intValue];
        self.source = [dic objectForKey:@"source"];
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"width.....%d\nheight.....%d\nurl.....%@",self.width,self.height,self.source];
    
}

@end
