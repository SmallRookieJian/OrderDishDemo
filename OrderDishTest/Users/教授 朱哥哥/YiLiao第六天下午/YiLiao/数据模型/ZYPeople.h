//
//  ZYPeople.h
//  YiLiao
//
//  Created by MrCheng on 16/3/18.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYPeople : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nickName;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *headerUrl;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
