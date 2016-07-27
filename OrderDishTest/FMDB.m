//
//  FMDB.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "FMDB.h"

@implementation FMDB

+ (FMDatabase *)getDataBase
{
    [self copyDatabaseToSandBox];
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"]];
    return fmdb;
}

+ (void)copyDatabaseToSandBox
{
    NSString * soucePath = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path] == NO)
    {
        [fileManager copyItemAtPath:soucePath toPath:path error:nil];
    }
}


@end
