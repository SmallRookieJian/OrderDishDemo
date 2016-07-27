//
//  CommentModel.h
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *info,*name;

+ (CommentModel *)parserWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;

@end
