//
//  FileRequest.m
//  eChat_01
//
//  Created by mac on 2016/3/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FileRequest.h"
#import "ASIHTTPRequest.h"

#import "ASIFormDataRequest.h"
#import "FileModel.h"
@implementation FileRequest
/**
 得到Token
 @param  无 不需要参数
 @return NSString
 */

- (NSString *)obtainToken {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    return token;
}

+ (void)gainFileListWithReturnBlock:(void (^)(NSArray *arrRtPerFile,NSArray *arrRtPubFile))blockReturn {
    NSString *token = [[self alloc] obtainToken];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/ycs/ps?command=%@&access_token=%@",@"ST_F_FL",token]]];
    [request setCompletionBlock:^{
        NSLog(@"fileRequest----->>>>%d",request.responseStatusCode);
        NSError *error = nil;
        NSDictionary *dicFromJSON = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dicFileList = [dicFromJSON objectForKey:@"filelist"];
        NSArray *arrPerFile = [dicFileList objectForKey:@"per_file"];
        NSArray *arrPubFile = [dicFileList objectForKey:@"pub_file"];
        
        NSMutableArray *arrWRPerFile = [NSMutableArray array];
        NSMutableArray *arrWRPubFile = [NSMutableArray array];
        for (NSDictionary *dic in arrPerFile) {
            
//            NSLog(@"------------------\n%@",[FileModel parserFromDic:dic]);
            
            [arrWRPerFile addObject:[FileModel parserFromDic:dic]];
        }
        for (NSDictionary *dic in arrPubFile) {
            [arrWRPubFile addObject:[FileModel parserFromDic:dic]];
        }
        blockReturn(arrWRPerFile,arrWRPubFile);
    }];
    [request startAsynchronous];
}
/*
 
 
 */


@end
