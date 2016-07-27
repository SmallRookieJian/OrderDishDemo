//
//  BmobTool.h
//  OrderDishTest
//
//  Created by mac on 2016/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;

typedef void (^BmobBlockDict)(BOOL isSuccess,NSArray *array);

typedef void (^BmobBlockArray)(BOOL isSuccess,NSArray *array);

@interface BmobTool : NSObject

/**
 *  创建一个单例
 *
 *  @return 返回单例
 */
+ (BmobTool *)shareBmobManager;

/**
 *  （根据BQL）查询某个表的数据
 *
 *  @param strBQL BQL字符串
 *  @param block isSuccess 查询是否成功,NSArray *array 查询结果以数组形式展现
 */
- (void)bmob_queryWithBQLTableName:(NSString *)tableName withBock:(BmobBlockDict)block;
//在这里算是一个难点吧，他请求回来的数据，既不是JSON格式的，也不是XML格式的，，所以需要花点心思处理

/**
 *  根据表的名字，还有一个信息，来查询数据
 *
 *  @param tableName 要查询的表名称
 *  @param info      查询的信息
 *  @param block     返回 isSuccess 和 一个 字典
 */
- (void)bmob_queryWithTableName:(NSString *)tableName withGroupID:(NSInteger)groupID withBlock:(BmobBlockArray)block;
/**
 *  根据用户名来查询用户（或者VIP账号）
 *
 *  @param userName 用户名称
 *  @param block    返回查询结果，结果中有两个值，isSuccess,array
 */
- (void)bmob_queryUserName:(NSString *)userName withBlock:(BmobBlockArray)block;

/**
 *  根据用户名（VIP账号、员工账号）、密码登录账号
 *
 *  @param userName 用户名
 *  @param passward 密码
 *  @param block    返回 isSuccess , array
 */
- (void)bmob_loginUserName:(NSString *)userName withPasswark:(NSString *)passward withDic:(NSDictionary *)dict withBlock:(BmobBlockArray)block;

/**
 *  给指定表添加数据
 *
 *  @param tableName 表名
 *  @param dictInfo  具体信息
 */
- (void)bmob_saveObjectWithTableName:(NSString *)tableName withDictInfo:(NSDictionary *)dictInfo withBlock:(void (^)(BOOL isSuccess,BmobObject *order))block;

/**
 *  根据数据库类名（表名）来查询数据库中记录的数量
 *
 *  @param className 数据库类名（表名）
 *
 *  @return 返回Block
 */
- (void)bmob_queryCountWithClassName:(NSString *)className withBlock:(void (^)(NSInteger number))block;

/**
 *  根据系统管理员名称登陆后
 *
 *  @param managerName 系统管理员名称
 *  @param block       登录结果
 */
- (void)bmob_loginManagerSystemWithName:(NSString *)managerName withPassword:(NSString *)passwork withBlock:(void (^)(BOOL isSuccess))block;

@end
