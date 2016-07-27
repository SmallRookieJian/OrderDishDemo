//
//  UserInfoRequest.h
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonalInfoModel;
@interface UserInfoRequest : NSObject

+ (void)obtainPersonalInfo:(void (^)(PersonalInfoModel *model))blockInfo;
+ (void)modifyPersonalInfoWithNickname:(NSString *)nickname WithEmail:(NSString *)email WithBlock:(void (^)(NSString *info))blockReturn;
+ (void)gainFrinedsList:(void (^)(NSArray *arrFriends))blockReturn;

+ (void)uploadHeaderImageWithImage:(NSData *)image WithReturnBlock:(void (^)(NSString *str))blockReturn;



@end
