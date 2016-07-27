//
//  FileModel.m
//  eChat_01
//
//  Created by mac on 2016/3/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FileModel.h"
#import "FileImageModel.h"
@implementation FileModel
+ (FileModel *)parserFromDic:(NSDictionary *)dic {
    return [[self alloc] initFromDic:dic];
}

// id   type    mimetype    image   image_url   url    name    description     author   tname   time    dtimes      length
- (id)initFromDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        self.file_id = [dic objectForKey:@"id"];
        self.type = [[dic objectForKey:@"type"] intValue];
        self.mimetype = [dic objectForKey:@"mimetype"];
        self.image_url = [dic objectForKey:@"image_url"];
        self.url = [dic objectForKey:@"url"];
        self.name = [dic objectForKey:@"name"];
        self.file_description = [dic objectForKey:@"description"];
        self.author = [dic objectForKey:@"author"];
        self.tname = [dic objectForKey:@"tname"];
        self.time = [dic objectForKey:@"time"];
        self.dtimes = [dic objectForKey:@"dtimes"];
        self.length = [[dic objectForKey:@"length"] longLongValue];
        
        self.imageModel = [FileImageModel parserFromDic:[dic objectForKey:@"image"]];
        
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id:%@\ntype:%d\nmimetype:%@\nimage_url:%@\nurl:%@\nname:%@\ndescription:%@\nauthor:%@\ntname:%@\ntime:%@\ndtimes:%@\nlength:%lld\nimage:%@",self.file_id,self.type,      self.mimetype,            self.image_url,           self.url,           self.name,            self.file_description,            self.author,            self.tname,            self.time,            self.dtimes,            self.length,            self.imageModel];
}

@end
