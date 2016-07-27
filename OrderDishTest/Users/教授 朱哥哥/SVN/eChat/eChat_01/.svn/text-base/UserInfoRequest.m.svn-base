//
//  UserInfoRequest.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UserInfoRequest.h"
#import "PersonalInfoModel.h"
#import "ASIFormDataRequest.h"


@implementation UserInfoRequest

+ (void)uploadHeaderImageWithImage:(NSData *)image WithReturnBlock:(void (^)(NSString *str))blockReturn {
    
    
    
    
}

- (NSString *)obtainToken {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
}

+ (void)obtainPersonalInfo:(void (^)(PersonalInfoModel *model))blockInfo
{
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/ycs/ps"]];
    [request setPostValue:@"ST_GPI" forKey:@"command"];
    
    
    //在本地获取 token
    NSString *access_token =[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    [request setPostValue:access_token forKey:@"access_token"];
    
    [request setCompletionBlock:^{
        
        NSLog(@"ObtainPerInfo--->>%d",request.responseStatusCode);
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        blockInfo([PersonalInfoModel parserWithDic:[dicFromJSON objectForKey:@"data"]]);
        
    }];
    [request startAsynchronous];
    
    
}

+ (void)modifyPersonalInfoWithNickname:(NSString *)nickname WithEmail:(NSString *)email WithBlock:(void (^)(NSString *info))blockReturn {
    
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/ycs/ps"]];
    [request setPostValue:@"ST_SPI" forKey:@"command"];
    //在本地获取token
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    [request setPostValue:access_token forKey:@"access_token"];
    [request setPostValue:nickname forKey:@"nickname"];
    [request setPostValue:email forKey:@"email"];
    
    [request setCompletionBlock:^{
        NSLog(@"modifyPerInfo--->>>statusCode_____%d",request.responseStatusCode);
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSString *info = [dicFromJSON objectForKey:@"info"];
        blockReturn(info);
        
        
    }];
    [request startAsynchronous];
}

+ (void)gainFrinedsList:(void (^)(NSArray *arrFriends))blockReturn
{
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/ycs/ps?command=%@&access_token=%@",@"ST_FL",access_token]]];
    [request setCompletionBlock:^{
        
        
        NSLog(@"FriendList--->>>statusCode_____%d",request.responseStatusCode);
//            NSLog(@"responseData_____%@",request.responseData);
        NSDictionary *dicFormJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *arrayData = [dicFormJSON objectForKey:@"data"];
        NSMutableArray *arrWillReturn = [NSMutableArray array];
        for (NSDictionary *dic in arrayData) {

            [arrWillReturn addObject:[PersonalInfoModel parserWithDic:dic]];
        }
        blockReturn(arrWillReturn);
        
    }];
    [request startAsynchronous];
    
    
//    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/st/s"]];
//    [request setPostValue:@"ST_FL" forKey:@"command"];
//    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
//    NSLog(@"access_token____%@",access_token);
//    [request setPostValue:access_token forKey:@"access_token"];
//    [request setCompletionBlock:^{
//        NSLog(@"FriendList--->>>statusCode_____%d",request.responseStatusCode);
//        NSLog(@"responseData_____%@",request.responseData);
//        NSDictionary *dicFormJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"JSON______%@",dicFormJSON);
//        NSArray *arrayData = [dicFormJSON objectForKey:@"data"];
//        NSLog(@"arrayData_____%@",arrayData);
//        NSMutableArray *arrWillReturn = [NSMutableArray array];
//        for (NSDictionary *dic in arrayData) {
//            
//            [arrWillReturn addObject:[PersonalInfoModel parserWithDic:dic]];
//            
//        }
//        
//        blockReturn(arrWillReturn);
//        
//    }];
//    [request startAsynchronous];
}

@end
