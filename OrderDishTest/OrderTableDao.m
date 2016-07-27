//
//  OrderTableDao.m
//  OrderDishTest
//
//  Created by mac on 16/2/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "OrderTableDao.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDB.h"
@implementation OrderTableDao

+ (void)insertOrderTable:(DishModel *)model
{
    NSLog(@"==!!!!!==%@",model.num);
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return;
    }
    [fmdb setShouldCacheStatements:YES];
    FMResultSet *result = [fmdb executeQuery:@"select *from orderTable where menuName = ?",model.name];
    if ([result next])
    {
        NSString *menuName = [result stringForColumn:@"menuName"];
        [fmdb executeUpdate:@"update orderTable set menuNum = ?,remark = ? where menuName = ?",model.num,model.detail,menuName];
        NSLog(@"修改成功");
    }
    else
    {
        [fmdb executeUpdate:@"insert into orderTable (id,menuName,Price,kind,menuNum,remark) values (?,?,?,?,?,?)",model.ID,model.name,model.price,model.iKind,@"1",@"无"];
    }
    [result close];
    [fmdb close];
}

+ (void)deleteOrderTable
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return;
    }
    [fmdb setShouldCacheStatements:YES];
    [fmdb executeUpdate:@"delete from orderTable"];
    [fmdb close];
}

+ (NSString *)countSum
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return nil;
    }
    [fmdb setShouldCacheStatements:YES];
    FMResultSet *result = [fmdb executeQuery:@"select *from orderTable"];
    NSString *sum = nil;
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
    while ([result next])
    {
        NSString *price = [result stringForColumn:@"Price"];
        NSString *num = [result stringForColumn:@"menuNum"];
       NSString *sum1 = [NSString stringWithFormat:@"%ld",[price integerValue]*[num integerValue]];
        [arr addObject:sum1];
    }
    [result close];
    [fmdb close];
    int summ = 0;
    for (int i = 0; i < arr.count; i++)
    {
        int a = [arr[i] intValue];
        summ = summ+a;
    }
    sum = [NSString stringWithFormat:@"%d",summ];
    return sum;
}

+ (void)insertDataToRoomRecordTable:(HistoryModel *)model
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return;
    }
    [fmdb setShouldCacheStatements:YES];
    [fmdb executeUpdate:@"insert into room_recordTable (date,time,room) values (?,?,?)",model.Hdate,model.Htime,model.Hroom];
    [fmdb close];
}

+ (NSMutableArray *)queryRoomRecordTable
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return nil;
    }
    [fmdb setShouldCacheStatements:YES];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    FMResultSet *Set = [fmdb executeQuery:@"select *from room_recordTable"];
    while ([Set next])
    {
        HistoryModel *model = [[HistoryModel alloc]init];
        model.Hdate = [Set stringForColumn:@"date"];
        model.Htime  = [Set stringForColumn:@"time"];
        model.Hroom = [Set stringForColumn:@"room"];
        model.HrowID = [Set stringForColumn:@"id"];
        [arr addObject:model];
    }
    [Set close];
    [fmdb close];
    return arr;
}

+ (void)deleteSelectedRowFromRoomRecordTable:(NSInteger)rowID
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return;
    }
    [fmdb setShouldCacheStatements:YES];
    [fmdb executeUpdate:@"delete from room_recordTable where id = ?",@(rowID)];
    [fmdb close];
}

+ (void)deleteAllDataFromRoomRecordTable
{
    FMDatabase *fmdb = [FMDB getDataBase];
    if (![fmdb open])
    {
        [fmdb close];
        return;
    }
    [fmdb setShouldCacheStatements:YES];
    [fmdb executeUpdate:@"delete from room_recordTable"];
    [fmdb close];
}

@end
