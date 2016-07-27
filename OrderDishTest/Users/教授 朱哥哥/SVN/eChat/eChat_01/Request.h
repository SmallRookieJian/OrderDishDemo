//
//  Request.h
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Request : NSObject

/**
 *  上传头像
 *  卧槽，这里需要注意的一点是：UIImage这个关键词不能再NSObject这个类中直接用，，，但幸运的是AFNetworking这个框架中导入了相应的头文件
 *  @param image 上传时用到的图片
 *  @param block 返回上传的结果，成功还是失败
 */
+ (void)uploadHeaderImage:(UIImage *)image block:(void(^)(BOOL isSuccess))block;

+ (void)detailNewsRequestWithString:(NSString *)string WithBlock:(void (^)(NSArray *arrayDatas,NSArray *arrayComments))blockNews;

+ (void)newsRequest:(void (^)(NSArray *arrayNews))blockNews;

+ (void)registeUser:(NSString *)userName WithPsw:(NSString *)psw WithNickname:(NSString *)nickName WithEmail:(NSString *)email WithResultBlock:(void (^)(NSDictionary *dic))blockResult;
+ (void)loginUser:(NSString *)userName WithPsw:(NSString *)psw WithLoginResultBlock:(void (^)(NSDictionary *dicResult))blockLoginResult;

@end
