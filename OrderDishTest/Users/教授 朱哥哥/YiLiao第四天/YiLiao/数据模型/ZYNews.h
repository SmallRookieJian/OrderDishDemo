//
//  ZYNews.h
//  YiLiao
//
//  Created by MrCheng on 16/3/17.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNews : NSObject

@property (nonatomic,assign)NSInteger newsID;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,copy)NSString *channel;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *source_url;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,assign)NSInteger readTimes;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,retain)NSArray *imgArr;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,assign)NSInteger width;
@property (nonatomic,assign)NSInteger height;

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
