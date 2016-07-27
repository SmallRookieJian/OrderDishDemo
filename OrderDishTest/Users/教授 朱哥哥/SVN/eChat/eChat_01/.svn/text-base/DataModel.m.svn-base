//
//  DataModel.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DataModel.h"
#import "DetailImageModel.h"
@implementation DataModel
+ (DataModel *)parserWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}
- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        self.data_type = [[dic objectForKey:@"data_type"] intValue];
        
//        NSLog(@"data_type.....%d",self.data_type);
        
        if (self.data_type == 1) {
            self.content = [dic objectForKey:@"content"];
//            NSLog(@"content.....%@",self.content);
        }
        if (self.data_type == 2) {
            self.imageModel = [DetailImageModel parserWithDic:[dic objectForKey:@"image"]];
//            NSLog(@"image.....%@",self.imageModel.source);
        }
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"data_type.....%d\ncontent.....%@\nimage.....%@",self.data_type,self.content,self.imageModel];
}

@end
