//
//  BmobTool.m
//  OrderDishTest
//
//  Created by mac on 2016/4/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BmobTool.h"
#import <BmobSDK/Bmob.h>
#import "DishModel.h"
#import "ButtonPageModel.h"
#import "AppDelegate.h"
#import "OrderTable+CoreDataProperties.h"
#import "HistoryModel.h"
#import "objc/runtime.h"

@implementation BmobTool

+ (BmobTool *)shareBmobManager {
    
    static BmobTool *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[BmobTool alloc] init];
        
    });
    
    return manager;
}

- (void)bmob_queryWithBQLTableName:(NSString *)tableName withBock:(BmobBlockDict)block {
    
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    NSString *bql = [NSString stringWithFormat:@"select * from %@",tableName];
    
    //在这里设置缓存策略，为先从缓存中读取，无论结果如何会再次从网络获取数据，返回两次结果
//    bmobQuery.cachePolicy = kBmobCachePolicyCacheThenNetwork;
    
    [bmobQuery queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        
        if (error) {
            NSLog(@"BmobTool ------ %@",error);
            block(NO,nil);
            return;
        }
        
        if (!result) {
            NSLog(@"BmobTool ------ 请求结果为空！！");
            block(NO,nil);
            return;
        }
            
        //没有错误，也请求到了结果，然后处理数据了
        
//        NSMutableArray *arrayImageURL = [NSMutableArray array];
//        NSMutableArray *arrayHImageURL = [NSMutableArray array];
        
//        NSLog(@"%@",[result.resultsAry[0] class]);
        
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        for (BmobObject *object in result.resultsAry) {
            
//            NSLog(@"%@,%@",[object class],[object objectForKey:@"kind"]);
            
            //得到自己生成的属性以及相关的数据字典
            
//            NSDictionary *dic = [object objectForKey:@"date"];
            
//            //得到文件模型
//            BmobFile *imgFile = [dic objectForKey:@"image"];
//
//            NSString *strImg = imgFile.url;
//            
//            NSURL *urlImage = [NSURL URLWithString:strImg];
//
//            [arrayImageURL addObject:urlImage];
//
//            BmobFile *himgFile = [dic objectForKey:@"highlighted_image"];
//            
//            NSString *strHImg = himgFile.url;
//            NSURL *urlHImage = [NSURL URLWithString:strHImg];
//            [arrayHImageURL addObject:urlHImage];
            
            if ([tableName isEqualToString:@"groupTable"]) {
                ButtonPageModel *btnPageModel = [[ButtonPageModel alloc] initWithBmobObject:object];
                
//                NSLog(@"BmobTool btnPageModel  %@",btnPageModel);
                
                [arrayModels addObject:btnPageModel];
            }
            else if ([tableName isEqualToString:@"OrderRecord"]) {
                
//                NSLog(@"这是结果%@",result.resultsAry);
                HistoryModel *orderRecord = [[HistoryModel alloc] initWithObject:object];
                
//                HistoryModel *orderRecord = [[HistoryModel alloc] init];
//                orderRecord.orderID = [orderRecord valueForKey:@"date"];
//                NSLog(@"这里是得到的模型：%@",orderRecord);
                [arrayModels addObject:orderRecord];
//                BmobObject
                
            }
        }
//        NSDictionary *dicReturn = @{@"arrHImageURLStr":arrayHImageURL,@"arrImageURLStr":arrayImageURL};
        
//        NSLog(@"BmobTool --- BQL %@,%s",arrayModels,__func__);
        
        block(YES,arrayModels);
        
    }];
    
}

- (void)bmob_queryWithTableName:(NSString *)tableName withGroupID:(NSInteger)groupID withBlock:(BmobBlockArray)block {
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    NSString *bqll = [NSString stringWithFormat:@"select * from %@ where groupID = %ld",tableName,groupID];
    
    [bmobQuery queryInBackgroundWithBQL:bqll block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"BmobTool ------ %@",error);
            block(NO,nil);
            return;
        }
        if (!result) {
            NSLog(@"BmobTool ------ 请求结果为空！！");
            block(NO,nil);
            return;
        }
        //在这里处理数据
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict in result.resultsAry) {
            DishModel *model = [[DishModel alloc] initWithDict:dict];
            [arrayModels addObject:model];
        }
        block(YES,arrayModels);
    }];
}

- (void)bmob_queryUserName:(NSString *)userName withBlock:(BmobBlockArray)block {
    
    BmobQuery *query = [BmobQuery queryForUser];
    [query whereKey:@"username" equalTo:userName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        NSMutableArray *arrayReturn = [NSMutableArray array];
        
        
        BOOL isSuccess = YES;
        
        
        if (!array.count) {
            
            isSuccess = NO;
            arrayReturn = nil;
        }
        else {
            isSuccess = YES;
            [arrayReturn addObjectsFromArray:array];
        }
        
        block(isSuccess,arrayReturn);
        
    }];
    
}

- (void)bmob_loginUserName:(NSString *)userName withPasswark:(NSString *)passward withDic:(NSDictionary *)dict withBlock:(BmobBlockArray)block {
    
    //在这里已经将数据整理好了
    //首先 根据员工账号 登录
    
    //登录成功之后的话，根据员工账号能够上传订单，，用异步上传，，并且得到订单信息，
    
    //通过订单信息，来上传历史菜单的菜品
    
    
    //上传，结束
    
    
    NSDictionary *dictOrderRecord = [dict objectForKey:@"OrderRecord"];
    
//    NSLog(@"%@",dict);
    
    [BmobUser loginWithUsernameInBackground:userName password:passward block:^(BmobUser *user, NSError *error) {
        
        if (error) {
            
            block(NO,nil);
            return;
            
        }
        
        //登录成功了，该上传信息了
        
        //新上传历史订单
        
        [dictOrderRecord setValue:user forKey:@"WorkerNum"];
        
        //在上传历史订单之前，需要统计一下现在OrderRecord表中有多少条记录，，，方便以后取出（统计记录条数的原因是因为在没有手动存储历史菜单记录条数的情况下，是取不到OrderID这条字段下的数据的
        
        [self bmob_queryCountWithClassName:@"OrderRecord" withBlock:^(NSInteger number) {
           
            //到这里已经得到了OrderRecord中记录的总数量，可以记录了
            
            [dictOrderRecord setValue:[NSNumber numberWithInteger:number+1] forKey:@"OrderID"];
            
            
            
             [self bmob_saveObjectWithTableName:@"OrderRecord" withDictInfo:dictOrderRecord withBlock:^(BOOL isSuccess, BmobObject *order) {
             
             
             if (!isSuccess) {
             
                 block(isSuccess,nil);
                 return;
             }
             else {
             
                 //在这里，保存订单信息保存成功，，，，，，，然后保存具体订单中菜品的信息
                 
                 
                 //此处为本地点餐订单
                 AppDelegate *app = [[AppDelegate alloc] init];
                 NSArray *arrayOrderTableModel = [app selectEntity:@"OrderTable" withPrediacte:nil];
                 
                 NSLog(@"我要保存，具体的菜品信息了");
                 NSLog(@"%@",arrayOrderTableModel);
                 
                 //TODO:在这里出了些问题,导致很长时间内没有解决,就是我明明已经得到了BmobObject的对象,但是就是得不到对象的某个属性
                 //解决办法:先绕开这个问题,用其他的方式来得到这个属性
                 
                 //在这里先得到这个订单的,
                 
                 //在等等问题结果吧
                 /*
                  
                  留着
                  
                  */
                 
                 //现在先上传具体的菜品信息,其中点餐的订单号还不能上传,,,未定
                 
                 for (OrderTable *orderTableCoreDataModel in arrayOrderTableModel) {
 
                     BmobObject *object = [[BmobObject alloc] initWithClassName:@"HistoryOrderDishRecord"];
                     /*
                      这里还少一个orderID没有保存
                      */
                     
                     NSNumber *numID = [NSNumber numberWithInteger:number];
                     [object setObject:numID forKey:@"OrderID"];
                     
                     [object setObject:orderTableCoreDataModel.name forKey:@"name"];
                     
                     //在这里出了些问题,,,由于做模型的时候处于方便的惰性心理,结果在这里和服务器对接的时候,两种类型对不上,所以有两次的类型转换,恶果啊!
                     
                     NSNumber *price = [NSNumber numberWithInteger:[orderTableCoreDataModel.price integerValue]];
                     [object setObject:price forKey:@"price"];
                     
                     NSNumber *num = [NSNumber numberWithInteger:[orderTableCoreDataModel.num integerValue]];
                     
                     [object setObject:num forKey:@"num"];
                     [object setObject:orderTableCoreDataModel.detail forKey:@"detail"];
                     
                     //object 对象已经将属性设定好了,可以保存了
                     
                     [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        
                         if (error) {
                              NSLog(@"上传历史菜单详细菜品信息错误,%@",error);
                             block(NO,nil);
                             return;
                         }
                         
                         block(YES,nil);
                         
                         
                     }];
                     
                 }
                 
                 //
                 //                for (OrderTable *orderTableCoreDataModel in arrayOrderTableModel) {
                 //
                 //                    BmobObject *object = [[BmobObject alloc] initWithClassName:@"HistoryOrder"];
                 //                    [object setObject:orderID forKey:@"OrderID"];
                 //                    [object setObject:orderTableCoreDataModel.name forKey:@"name"];
                 //                    [object setObject:orderTableCoreDataModel.price forKey:@"price"];
                 //                    [object setObject:orderTableCoreDataModel.num forKey:@"num"];
                 //                    [object setObject:orderTableCoreDataModel.detail forKey:@"detail"];
                 //
                 //
                 //                    //先上传这么多，还差一个unit
                 //                    [object saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                 //
                 //                        if (!isSuccess) {
                 //                            NSLog(@"保存错误！");
                 //                            NSLog(@"%@",error);
                 //
                 //                            block(NO,nil);
                 //                            return ;
                 //
                 //                        }
                 //
                 //                        //保存成功
                 //
                 //                        
                 //                        block(YES,nil);
                 //                        
                 //                    }];
                 //                    
                 //                    
                 //                }
                 //                
             
             }
             
             
             }];
            
        }];
        
        
    }];
    
}


- (void)bmob_saveObjectWithTableName:(NSString *)tableName withDictInfo:(NSDictionary *)dictInfo withBlock:(void (^)(BOOL isSuccess,BmobObject *order))block {
    
    BmobObject *order = [BmobObject objectWithClassName:tableName];
    
    NSArray *arrayProperty = [dictInfo allKeys];
    
    for (NSString *propertyName in arrayProperty) {
        
        [order setObject:[dictInfo objectForKey:propertyName] forKey:propertyName];
        
    }
    
    [order saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!isSuccessful) {
            
            NSLog(@" 保存错误 error %@",error);
            
            block(isSuccessful,nil);
            return;
        }
        
        //到了这里就保存数据成功了
        
        block(isSuccessful,order);
        
        NSLog(@"在这里输出下 保存成功的 bombObject   %@",order);
        
    }];
    
}

- (void)bmob_queryCountWithClassName:(NSString *)className withBlock:(void (^)(NSInteger number))block {
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:className];
    
    [bquery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        
        if (error) {
            NSLog(@"根据表名查询条数出现错误");
            return;
        }
        
        
        block(number);
        
    }];
    
}


- (void)bmob_loginManagerSystemWithName:(NSString *)managerName withPassword:(NSString *)passwork withBlock:(void (^)(BOOL isSuccess))block {
    
    [BmobUser loginWithUsernameInBackground:managerName password:passwork block:^(BmobUser *user, NSError *error) {
        if (error) {
            
            NSLog(@"%s 登录失败",__func__);
            
            block(NO);
            
            return;
        }
        //登录成功
        
        block(YES);
        
    }];
    
}

@end
