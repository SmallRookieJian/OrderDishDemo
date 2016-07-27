//
//  AppDelegate.m
//  OrderDishTest
//
//  Created by mac on 16/2/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "OrderTableDao.h"

#import <BmobSDK/bmob.h>
#import "OtherPageViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [OrderTableDao deleteOrderTable];
    FirstViewController *vc = [[FirstViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    
    //注册应用
    [Bmob registerWithAppKey:@"6c2271b8e5f462efcf402911c5f5fe13"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//应用程序的沙盒目录 返回一个地址信息
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zhiyou100.CoreDataDemo" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //    注意修改地址
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OrderDishTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

//这个方法内的内容 尽量不要修改
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    //    数据库存储的位置
    
    //    需要修改数据库的名字
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OrderDishTest.sqlite"];
    
    //    容错处理
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        //        中转站不存在的话 就不能使用数据库
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //coreData 主线程中使用
    //coreData 是一个多线程的数据库
    
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    //    一般声明上下文都要用这种形式
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //存储数据库
            abort();
        }
    }
}

#pragma mark -
#pragma mark coredata封装
//增加内容
/* coreData 添加内容
 * 传入参数 ：实例名   需要添加的参数
 * 时间 作者
 */
- (void)addNewEntity:(NSString *)entityName withInfo:(NSDictionary *)info
{
    
//    static AppDelegate *appdelegates;
    NSManagedObjectContext *context = self.managedObjectContext;
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    NSArray *keyArray = [info allKeys];
    for (NSString *key in keyArray) {
        
        [object setValue:[info objectForKey:key] forKey:key];
    }
    
    [self saveContext];
}

//查找
- (NSArray *)selectEntity:(NSString *)entityName withPrediacte:(NSString *)prediacte
{
//    static AppDelegate *appdelegates;
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    //查找的内容有可能有很多 所以要用数组去接收它
    //    查找的时候需要添加查找的条件
    //    针对coreData中实例的选择而创建的一个请求方式
    //    数据库有数据库语句来支持数据的增删改查
    //    codeData的删改查数据利用NSFetchRequest来进行
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc]init];
    //设置需要查询的实例
    fetch.entity = entity;
    
    if (prediacte) {
        //设置查询条件
        NSPredicate *prediactes = [NSPredicate predicateWithFormat:prediacte];
        
        fetch.predicate = prediactes;
    }
    
    //    上下文去查找 查询结果是一个数组
    
    NSError *error = nil;
    
    NSArray *arrayQueryResult = [context executeFetchRequest:fetch error:&error];
    
    if (error) {
        return nil;
    }
    else {
        return arrayQueryResult;
    }
    
}

//删除一个对象
- (void)deleteObject:(NSManagedObject *)deletObject
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    //删除指定的对象
    [context deleteObject:deletObject];
    
    //删除所有的对象
    //    [context deletedObjects];
    [self saveContext];
}

////改
//- (void)changedEntitywith:(NSManagedObject *)changeObject withInfo:(NSDictionary *)info
//{
////    static AppDelegate *appdelegates;
//    
//    NSLog(@"changed entity %@",changeObject);
//    
//    NSManagedObjectContext *context = self.managedObjectContext;
//    
//    NSArray *keyArray = [info allKeys];
//    for (NSString *key in keyArray) {
//        
//        [changeObject setValue:[info objectForKey:key] forKey:key];
//    }
//    
//    [self saveContext];
//    
//}

- (void)increaseNewOrderDish:(NSString *)entityName withInfo:(NSDictionary *)dictInfo {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    //想要给已经点好的菜品中添加新点的菜，在这里需要做以下几步
    //1.先要查看我已经点的菜品种是否已经有了这个菜？
    
    NSString *strPrediacte = [NSString stringWithFormat:@"name == '%@'",[dictInfo objectForKey:@"name"]];
    
    NSArray *arrayQueryResult = [self selectEntity:entityName withPrediacte:strPrediacte];
    
    //在这里尝试着获取下数据库文件的存储位置吧
//    NSLog(@"%@",[[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"]);
    NSLog(@"%@",NSHomeDirectory());
    
    if (arrayQueryResult.count != 0) {
        //2.有的话，需要修改已点菜品的份数
        
        //修改
        //2.1 先得到现在已有菜品份数
        NSManagedObject *object = [arrayQueryResult firstObject];
        NSInteger numPrimitive = [[object primitiveValueForKey:@"num"] integerValue];
        
        //2.2 修改份数
        numPrimitive++;
        
        //2.3 存入
        [object setValue:[NSString stringWithFormat:@"%ld",numPrimitive] forKey:@"num"];
        
        [self saveContext];
        
    }
    else {
        
        //3.没有的话，则在我的点单中增加新的菜品
        
        //直接增加新的菜品
        
        NSArray *arrayDescriptions = [dictInfo allKeys];
        
        NSManagedObject *objectAdd = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
        
        for (NSString *str in arrayDescriptions) {
            
            [objectAdd setValue:[dictInfo objectForKey:str] forKey:str];
        }
        
        [self saveContext];
    }
    
}

- (void)changeEntityName:(NSString *)entityName withInfo:(NSDictionary *)dictInfo {
    
    //我先查找
    NSString *name = [dictInfo objectForKey:@"name"];
    
    if (name == nil) {
        NSLog(@"change entity name 根本就没有这个要改的实体");
        return;
    }
    
    NSString *prediacte = [NSString stringWithFormat:@"name == '%@'",name];
    
    NSArray *array = [self selectEntity:entityName withPrediacte:prediacte];
    
    NSManagedObject *object = [array firstObject];
    
    NSArray *arrayPropertyName = [dictInfo allKeys];
    
    for (NSString *str in arrayPropertyName) {
        
        [object setValue:[dictInfo objectForKey:str] forKey:str];
        
    }
    
    [self saveContext];
}

//- (NSArray *)changeModelFromManagerObjectToDishModel:(NSArray *)arrayManagerObject {
//    
//    NSManagedObjectContext *context = self.managedObjectContext;
//    
//    NSMutableArray *array = [NSMutableArray array];
//    
//    for (NSManagedObject *object in arrayManagerObject) {
//        
//        DishModel *model = [[DishModel alloc] init];
//        model.name = [object valueForKey:@"name"];
//        model.price = [object valueForKey:@"price"];
//        model.num = [object valueForKey:@"num"];
//        model.detail = [object valueForKey:@"detail"];
//        model.iKind = [object valueForKey:@"iKind"];
//        
//        [array addObject:model];
//    }
//    return array;
//}

//- (NSArray *)queryAllOrderDish {
//    
//    NSManagedObjectContext *context = self.managedObjectContext;
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
//    
//}

- (void)clearTable {
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"OrderTable" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setIncludesPropertyValues:NO];
    
    [request setEntity:description];
    
    NSError *error = nil;
    
    NSArray *datas = [context executeFetchRequest:request error:&error];
    
    if (!error && datas && [datas count])  
    {
        
        for (NSManagedObject *obj in datas)
        {
            
            [context deleteObject:obj];
            
        }  
        
        if (![context save:&error])
        {  
            
            NSLog(@"error:%@",error);  
            
        }  
        
    }
    
    
}


@end
