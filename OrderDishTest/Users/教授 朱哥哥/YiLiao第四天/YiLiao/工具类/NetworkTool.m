//
//  NetworkTool.m
//  YiLiao
//
//  Created by MrCheng on 16/3/15.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
//注册新用户
+ (void)registNewUserWithName:(NSString *)name passWord:(NSString *)psw nickName:(NSString *)nickName email:(NSString *)email block:(void(^)(BOOL isSuccess))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = @{
                                @"command":@"ST_R",
                                @"name":name,
                                @"psw":psw,
                                @"nickname":nickName,
                                @"email":email
                                };
    //发送POST请求
    //参数1:请求的url(字符串)
    //参数2:请求参数(Get和POST的参数都是放在这里,以字典的形式)
    [manager POST:HOST_ADDR parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSString *error = [responseObject objectForKey:@"error"];
        if (error) {
            //显示透明指示层
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return;
        }
        if (block)
        {
            block(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"%@",error);
    }];
}
//登录
+ (void)loginUserWithName:(NSString *)name password:(NSString *)psw block:(void(^)(BOOL isSuccess))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = @{
                                @"command":@"ST_L",
                                @"name":name,
                                @"psw":psw
                                };
    [manager POST:HOST_ADDR parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *error = [responseObject objectForKey:@"error"];
        if (error)
        {
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return ;
        }
        //获取token和过期时间间隔
        NSString *token = [responseObject objectForKey:@"access_token"];
        NSInteger time = [[responseObject objectForKey:@"time"] integerValue];
        NSDate *deadTime = [NSDate dateWithTimeIntervalSinceNow:time];
        //保存token和过期时间,用于检测自动登录
        [USER_DEF setObject:token forKey:USER_TOKEN];
        [USER_DEF setObject:deadTime forKey:USER_DEADTIME];
        [USER_DEF synchronize];
        if (block)
        {
            block(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//获取新闻列表
+ (void)requestNewsListWithblock:(void(^)(NSDictionary *dic))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://localhost:8080/st/news/news_list.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *error = [responseObject objectForKey:@"error"];
        if (error) {
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return;
        }
        if (block) {
            block(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//获取新闻的详细信息
+ (void)requestNewsDetailInformation:(NSString *)urlStr block:(void(^)(NSDictionary *dic))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",HOST,urlStr] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject);//把获取到的新闻信息传递到详细页面
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//获取朋友列表信息
+ (void)requestFriendListInfo:(void (^)(NSDictionary *dic))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"%@?command=ST_FL&access_token=%@",HOST_ADDR,[USER_DEF objectForKey:USER_TOKEN]];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *error = [responseObject objectForKey:@"error"];
        if (error) {
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return;
        }
        if (block) {
            block(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求朋友列表失败!");
    }];
}

//上传头像
+ (void)uploadHeaderImage:(UIImage *)image block:(void(^)(BOOL isSuccess))block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?command=ST_H&access_token=%@",HOST_ADDR,[USER_DEF objectForKey:USER_TOKEN]];
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSData *data = UIImagePNGRepresentation(image);
    NSMutableData *imgData = [NSMutableData dataWithData:data];
    request.postBody = imgData;
    //请求结束后回调block
    [request setCompletionBlock:^{
        NSDictionary *dic = request.responseString.JSONValue;
        NSString *error = [dic objectForKey:@"error"];
        if (error) {
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return;
        }
        if (block) {
            block(YES);
        }
    }];
    //请求失败后回调block
    [request setFailedBlock:^{
        NSLog(@"错误");
    }];
    //开始上传
    [request startAsynchronous];
}

//修改个人信息
+ (void)changeSelfInfoWithNickName:(NSString *)nickName WithEmail:(NSString *)email block:(void(^)(BOOL isSuccess))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *para = @{
                           @"command":@"ST_SPI",
                           @"access_token":[USER_DEF objectForKey:USER_TOKEN],
                           @"nickname":nickName,
                           @"email":email
                           };
    [manager POST:HOST_ADDR parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *error = [responseObject objectForKey:@"error"];
        if (error) {
            [APP_WIN showHUDWithText:error Type:ShowPhotoNo Enabled:YES];
            return;
        }
        if (block) {
            block(YES);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误");
    }];
}


+(void)requestFileList:(HTTPFileListBlock)Block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@?command=ST_F_FL&access_token=%@",HOST_ADDR,[USER_DEF objectForKey:USER_TOKEN]];
    NSURL *url = [NSURL URLWithString:urlStr];

    NSLog(@"--%@",url);

    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"---%ld",dict.count);

        if (dict.count !=0 ) {
            FileListModel *model = [[FileListModel alloc]initWithItem:dict];
            Block(YES,model);
        }else
        {
            Block(NO,nil);
        }

    }];

    [request startAsynchronous];

}





















@end
