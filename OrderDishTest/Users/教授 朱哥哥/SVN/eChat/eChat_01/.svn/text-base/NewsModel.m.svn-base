//
//  NewsModel.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NewsModel.h"
#import "ImageModel.h"


@implementation NewsModel

+ (NewsModel *)parserWithDic:(NSDictionary *)dic {
    
    return [[self alloc] initWithDic:dic];
    
}
- (id)initWithDic:(NSDictionary *)dic {
    
    
    //int news_ID,news_type;
//    @property (nonatomic, copy) NSString *channel,*news_title,*intro;
//    @property (nonatomic, copy) NSString *source_url,*time,*source;
//    @property (nonatomic, copy) NSString *readtimes,*auther;
    self = [super init];
    if (self) {
        
        self.news_ID = [[dic objectForKey:@"id"] intValue];
        self.news_type = [[dic objectForKey:@"type"] intValue];
        self.channel = [dic objectForKey:@"channel"];
        self.news_title = [dic objectForKey:@"news_title"];
        self.intro = [dic objectForKey:@"intro"];
        self.source_url = [dic objectForKey:@"source_url"];
        self.time = [dic objectForKey:@"time"];
        self.source = [dic objectForKey:@"source"];
        self.readtimes = [dic objectForKey:@"readtimes"];
        self.auther = [dic objectForKey:@"auther"];
        
        
        NSArray *arrayDicImages = [dic objectForKey:@"images"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in arrayDicImages) {
            
            [array addObject:[ImageModel parserWithDic:dic]];
            
        }
        
        self.arrayImages = array;
        
    }
    return self;
}
/*
 int news_ID,news_type;
 @property (nonatomic, copy) NSString *channel,*news_title,*intro;
 @property (nonatomic, copy) NSString /Users/mac/Desktop/新校区/eChat_01/eChat_01/NewsModel.m*source_url,*time,*source;
 @property (nonatomic, copy) NSString *readtimes,*auther;
 
 
 */


- (NSString *)description {
    
    return [NSString stringWithFormat:@"id_____%d\ntype_____%d\nchannel_____%@\ntitle_____%@\nintro_____%@\nsource_url_____%@\ntime_____%@\nsource_____%@\nreadtimes_____%@\nauther_____%@\nimage.count_____%d",self.news_ID,self.news_type,self.channel,self.news_title,self.intro,self.source_url,self.time,self.source,self.readtimes,self.auther,self.arrayImages.count];
    
}

@end
