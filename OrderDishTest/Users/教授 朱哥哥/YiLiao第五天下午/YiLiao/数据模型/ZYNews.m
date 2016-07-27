//
//  ZYNews.m
//  YiLiao
//
//  Created by MrCheng on 16/3/17.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "ZYNews.h"

@implementation ZYNews

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.newsID = [[dic objectForKey:@"id"] integerValue];
        self.type = [[dic objectForKey:@"type"] integerValue];
        self.channel = [dic objectForKey:@"channel"];
        self.title = [dic objectForKey:@"news_title"];
        self.intro = [dic objectForKey:@"intro"];
        self.source_url = [dic objectForKey:@"source_url"];
        self.time = [dic objectForKey:@"time"];
        self.source = [dic objectForKey:@"source"];
        self.readTimes = [[dic objectForKey:@"readtimes"] integerValue];
        self.author = [dic objectForKey:@"auther"];
        self.imgArr = [dic objectForKey:@"images"];
        self.imgUrl = [[[dic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"url"];
        ;
        self.width = [[[[dic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"width"] integerValue];
        self.height = [[[[dic objectForKey:@"images"] objectAtIndex:0] objectForKey:@"height"] integerValue];
    }
    return self;
}



@end
