//
//  ImageModel.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+ (ImageModel *)parserWithDic:(NSDictionary *)dic {
    
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
        self.url = [dic objectForKey:@"url"];
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"width.....%d\nheight.....%d\nurl.....%@",self.width,self.height,self.url];
    
}

@end
