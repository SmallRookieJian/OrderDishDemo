//
//  NetworkTool.h
//  YiLiao
//
//  Created by MrCheng on 16/3/15.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "FileListModel.h"

//block 单独拿出来写
//这样比较清晰 并且可以反复利用
typedef void (^HTTPFileListBlock)(BOOL,FileListModel*);

@interface NetworkTool : NSObject

//注册用户
+ (void)registNewUserWithName:(NSString *)name passWord:(NSString *)psw nickName:(NSString *)nickName email:(NSString *)email block:(void(^)(BOOL isSuccess))block;
//登录接口
+ (void)loginUserWithName:(NSString *)name password:(NSString *)psw block:(void(^)(BOOL isSuccess))block;
//获取新闻列表
+ (void)requestNewsListWithblock:(void(^)(NSDictionary *dic))block;
//获取新闻的详细内容
+ (void)requestNewsDetailInformation:(NSString *)urlStr block:(void(^)(NSDictionary *dic))block;
//获取朋友列表信息
+ (void)requestFriendListInfo:(void(^)(NSDictionary *dic))block;
//上传头像
+ (void)uploadHeaderImage:(UIImage *)image block:(void(^)(BOOL isSuccess))block;
//修改个人信息
+ (void)changeSelfInfoWithNickName:(NSString *)nickName WithEmail:(NSString *)email block:(void(^)(BOOL isSuccess))block;

//请求文件列表
//返回数据 1：请求是否成功  2：返回参数FileListModel 对象
+(void)requestFileList:(HTTPFileListBlock)Block;








@end
