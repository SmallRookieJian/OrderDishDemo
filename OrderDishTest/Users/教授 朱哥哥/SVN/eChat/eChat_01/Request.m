//
//  Request.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "Request.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "NewsModel.h"
#import "DataModel.h"
#import "CommentModel.h"

//http://localhost:8080/ycs/ps
//新闻资源 前缀http://localhost:8080

@implementation Request
/**
 *  获得存储在本地的token
 *
 *  @return 返回值是NSString类型的token
 */
- (NSString *)obtainToken {

    return [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
}

+ (void)uploadHeaderImage:(UIImage *)image block:(void(^)(BOOL isSuccess))block {
    
    NSString *strURL = [NSString stringWithFormat:@"http://localhost:8080/ycs/ps?command=%@&access_token=%@",@"ST_H",[[self alloc] obtainToken]];
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strURL]];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    NSMutableData *imageData = [NSMutableData dataWithData:data];
    request.postBody = imageData;
    //请求结束后回调block
    [request setCompletionBlock:^{
        NSLog(@"uploadHeaderImage----->>>statusCode:%d",request.responseStatusCode);
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSString *info = [dicFromJSON objectForKey:@"info"];
        NSString *error = [dicFromJSON objectForKey:@"error"];
        if (error) {
            //上传出现错误
            [APP_WIN showHUDWithText:info Type:ShowPhotoNo Enabled:YES];
            return;
            
        }
        
        if (block) {
            block(YES);
        }
        
    }];
    
    //请求失败后回调block
    [request setFailedBlock:^{
        NSLog(@"请求发送失败");
    }];
    
    [request startAsynchronous];
}

+ (void)detailNewsRequestWithString:(NSString *)stringURL WithBlock:(void (^)(NSArray *arrayDatas,NSArray *arrayComments))blockNews {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080%@",stringURL]];
    
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        
        NSLog(@"Detail--》》responseStatusCode____%d",request.responseStatusCode);
//        NSLog(@"responseString_____________%@",request.responseString);
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"dic_______\n%@",dicFromJSON);
//        NSLog(@"keys______\n%@",[dicFromJSON allKeys]);
        //再返回的字典中有 comments    info    data三个字典
        
//        NSLog(@"dicFromJSON_____%@",dicFromJSON);
        
        NSArray *arrayComments = [dicFromJSON objectForKey:@"comments"];
        NSArray *arrayData = [dicFromJSON objectForKey:@"data"];
//        NSDictionary *dicInfo = [dicFromJSON objectForKey:@"info"];
        
//        NSLog(@"comment:%@\ndata:%@\ninfo:%@",arrayComments,arrayData,dicInfo);
        
        NSMutableArray *arrayReturnData = [NSMutableArray array];
        NSMutableArray *arrayReturnComments = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in arrayData) {
            
//            NSLog(@"--->>>%@",[DataModel parserWithDic:dic]);
            
            [arrayReturnData addObject:[DataModel parserWithDic:dic]];
        }
        for (NSDictionary *dic in arrayComments) {
//            NSLog(@"--->>>%@",[CommentModel parserWithDic:dic]);
            [arrayReturnComments addObject:[CommentModel parserWithDic:dic]];
        }
        
        blockNews(arrayReturnData,arrayReturnComments);
        
    }];
    [request startAsynchronous];
    
}

+ (void)newsRequest:(void (^)(NSArray *arrayNews))blockNews {
    
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/ycs/news/news_list.json"]];
    [request setCompletionBlock:^{
        
        NSLog(@"News--》》responseStatusCode____%d",request.responseStatusCode);
//        NSLog(@"responseString_____________%@",request.responseString);
        
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
//        NSLog(@"-----------\n%@",dicFromJSON);
        
        NSArray *arrayNewsList = [dicFromJSON objectForKey:@"news_list"];
        
        NSMutableArray *arrayResultNewsList = [NSMutableArray array];
        for (NSDictionary *dicNew in arrayNewsList) {
            
            [arrayResultNewsList addObject:[NewsModel parserWithDic:dicNew]];
        }
        
        
        blockNews(arrayResultNewsList);
        
        
    }];
    [request startAsynchronous];
    
}


+ (void)registeUser:(NSString *)userName WithPsw:(NSString *)psw WithNickname:(NSString *)nickName WithEmail:(NSString *)email WithResultBlock:(void (^)(NSDictionary *dic))blockResult {
    
    //向服务器发送请求
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/ycs/ps"]];
    request.delegate = self;
    //    [request setValue:@"ST_R" forKey:@"command"];
    [request setPostValue:@"ST_R" forKey:@"command"];
    [request setPostValue:userName forKey:@"name"];
    [request setPostValue:psw forKey:@"psw"];
    
    if (nickName.length) {
        [request setPostValue:nickName forKey:@"nickname"];
    }
    if (email.length) {
        [request setPostValue:email forKey:@"email"];
    }
    
    [request setCompletionBlock:^{
        
        NSLog(@"Registe-->>statusCode______%d",request.responseStatusCode);
        NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        //这里是传值的关键
        blockResult(requestDic);
        
    }];
    
    [request startSynchronous];

}


+ (void)loginUser:(NSString *)userName WithPsw:(NSString *)psw WithLoginResultBlock:(void (^)(NSDictionary *dicResult))blockLoginResult {
    
    //向服务器发送请求
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/ycs/ps"]];
    request.delegate = self;
    //    [request setValue:@"ST_R" forKey:@"command"];
    [request setPostValue:@"ST_L" forKey:@"command"];
    [request setPostValue:userName forKey:@"name"];
    [request setPostValue:psw forKey:@"psw"];
    
    [request setCompletionBlock:^{
        
        NSLog(@"Login-->>statusCode______%d",request.responseStatusCode);
        NSDictionary *requestDic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        //这里是传值的关键
        blockLoginResult(requestDic);
        
    }];
    
    [request startSynchronous];
    
}


@end
