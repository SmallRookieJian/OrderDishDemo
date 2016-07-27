//
//  AppDelegate.h
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//不需要再去导入coredata.framework
#import <CoreData/CoreData.h>
#import "DishModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//实现三个属性 两个方法

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存上下文 增删改
- (void)saveContext;

//获取沙盒地址
- (NSURL *)applicationDocumentsDirectory;

- (void)addNewEntity:(NSString *)entityName withInfo:(NSDictionary *)info;
- (NSArray *)selectEntity:(NSString *)entityName withPrediacte:(NSString *)prediacte;
- (void)deleteObject:(NSManagedObject *)deletObject;
//- (void)changedEntitywith:(NSManagedObject *)changeObject withInfo:(NSDictionary *)info;

/*
 
 我在这里写点关于CoreData的笔记，亡羊补牢吧！！
 
 他这里提到的entity （实例） 自认为应该是相当于sqlite中表单的一条记录
 
 sqlite 中的列名在CoreData中具体的称呼是描述
 
 */

//
///**
// *  根据实例模型来添加实体对象，
// *
// *  @param entityName 实例名称
// *  @param model      要存入CoreData中的实例模型
// */
//+ (void)addNewEntity:(NSString *)entityName withDishModel:(DishModel *)model;

/**
 *  往我的点单中增加菜品（新的菜品，或者增加份数）
 *
 *  @param entityName 这里entityName必须是首字母大写的字符串
 *  @param dictInfo   这个菜品的详细信息
 */
- (void)increaseNewOrderDish:(NSString *)entityName withInfo:(NSDictionary *)dictInfo;

- (void)changeEntityName:(NSString *)entityName withInfo:(NSDictionary *)dictInfo;

//- (NSArray *)changeModelFromManagerObjectToDishModel:(NSArray *)arrayDishModel;

//- (NSArray *)queryAllOrderDish;

- (void)clearTable;

@end
