//
//  ChefRecommendDAO.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ChefRecommendDAO.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDB.h"
#import "DishModel.h"

@implementation ChefRecommendDAO

+ (NSArray *)readHeaderData:(NSInteger)rightRowID
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return nil;
    }
   FMResultSet *resultSet = [fmdb executeQuery:@"select * from groupTable where id = ?",[NSNumber numberWithInteger:rightRowID+1]];
    NSArray *nameArr = [[NSArray alloc] init];
    while ([resultSet next])
    {
        NSString *nameOfKind = [resultSet stringForColumn:@"name"];
        nameArr = [nameOfKind componentsSeparatedByString:@"|"];
    }
    [resultSet close];
    [fmdb close];
    return nameArr;
}

+ (NSArray *)readRowData:(NSArray *)array
{
    [FMDB copyDatabaseToSandBox];
    NSMutableArray *sectionArr = [[NSMutableArray alloc]init];
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return nil;
    }
    for (int i = 0; i < array.count; i ++)
    {
        NSMutableArray *modelArr = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [fmdb executeQuery:@"select *from menuTable where iKind = ?",array[i]];
        while ([resultSet next])
        {
            DishModel *model = [[DishModel alloc] init];
            model.name = [resultSet stringForColumn:@"name"];
            model.price = [resultSet stringForColumn:@"price"];
            model.unit = [resultSet stringForColumn:@"unit"];
            model.iKind = [resultSet stringForColumn:@"iKind"];
            model.detail = [resultSet stringForColumn:@"detail"];
//            model.picName = [resultSet stringForColumn:@"picName"];
            [modelArr addObject:model];
        }
        [resultSet close];
        [sectionArr addObject:modelArr];
    }
    [fmdb close];
    
    return sectionArr;
    
}

+ (NSMutableArray *)getModelFromDatabase
{
    [FMDB copyDatabaseToSandBox];
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return nil;
    }
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [fmdb executeQuery:@"select * from orderTable"];
    while ([resultSet next])
    {
        DishModel *model = [[DishModel alloc] init];
        model.name = [resultSet stringForColumn:@"menuName"];
        model.price = [resultSet stringForColumn:@"Price"];
        model.iKind = [resultSet stringForColumn:@"kind"];
        model.num = [resultSet stringForColumn:@"menuNum"];
        model.detail = [resultSet stringForColumn:@"remark"];
        [arr addObject:model];
    }
    [resultSet close];
    [fmdb close];
    return arr;
}


@end
