//
//  NewsModel.h
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, assign) int news_ID,news_type;
@property (nonatomic, copy) NSString *channel,*news_title,*intro;
@property (nonatomic, copy) NSString *source_url,*time,*source;
@property (nonatomic, copy) NSString *readtimes,*auther;
@property (nonatomic, retain) NSArray *arrayImages;

+ (NewsModel *)parserWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;

@end
