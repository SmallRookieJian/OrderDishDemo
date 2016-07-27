//
//  FileManager.m
//  YiLiao
//
//  Created by Mega on 16/3/23.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileManager.h"
#import "NSString+MD5.h"
#import "ASIHTTPRequest.h"

@implementation FileManager

//单例的实现方法 1
//+(FileManager *)sharManager
//{
//    static FileManager *manager=  nil;
//    if (!manager) {
//        manager = [[FileManager alloc]init];
//    }
//    return manager;
//}

//单例的实现 2
+(FileManager *)sharManager
{

    static FileManager *manager = nil;
//    dispatch_once 的函数可保证在整个软件生命周期中之运行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FileManager alloc]init];
    });
    return manager;
}


//可以获取它的文件名 或者文件信息
-(NSString *)downLoadFileWithUrl:(FileInfoModel *)model
{
//    找到沙盒位置
    NSString *path = NSHomeDirectory();
    NSLog(@"---%@",path);
//获取Documents位置
    path = [path stringByAppendingPathComponent:@"Documents"];
    //保存或者查找某一个对象的时候 根据它的ID去查找
//    保存文件时 根据什么保存
//    文件原ID可以当做我们保存的ID 有可能会重复
//    文件名不能当做ID 它的重复率非常高
//    文件的url 也可以当做我们保存的ID
//    url 是服务器告诉我们的地址
//    url 字段非常的长 而且长度不固定
//需要对它进行计算 从而使他长度固定

//    MD5 算法  AES RSA  对称加密 非对称加密
    NSString *url_MD5 = model.url.md5HexDigest;

//    MD5 算法的特性
    /*
    1    md5算法 可以把任意长度的数据计算出固定的长度
     2   算法简单 且大多数API中都有现成的算法
     3 抗修改性很强  对元数据进行修改 任何改动都会造成反解析数据不一样
     4 强碰撞性 反解析数据时 因为它的唯一性 所伪造数据是很困难的
     */

//    NSLog(@"----%@---",url_MD5);
    //获取文件在Douctment中的位置
    path = [path stringByAppendingPathComponent:url_MD5];

//    最后添加文件格式
    int type = [model.type intValue];
    switch (type) {
        case 0:
            path = [path stringByAppendingString:@".pdf"];
            break;
        case 1:
            path = [path stringByAppendingString:@".mp3"];
            break;
        case 2:
            path = [path stringByAppendingString:@".mp4"];
            break;
        case 3:
            path = [path stringByAppendingString:@".doc"];
            break;
        case 4:
            path = [path stringByAppendingString:@".jpg"];
            break;

        default:
            break;
    }

    NSLog(@"---%@",path);

    return path;
}

//下载
-(void)downLoadFile:(FileInfoModel *)model
{

  NSString *downLoadPath = [self downLoadFileWithUrl:model];

//    NSFileManager 文件管理器

//下载之前需要判断当前文件是否已经下载过
//    判断方法 去本地找
//    去本地找的时候 最好直接获得它的下载状态
    BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:downLoadPath];
    if (isExists) {
        NSLog(@"文件以及存在");
//        再弹出一个提示框
        return;
    }
//    如果不存在 进行下载

    NSURL *url = [NSURL URLWithString:model.url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//开始下载
//    下载的位置
    request.downloadDestinationPath =downLoadPath;

//    downloadProgressDelegate返还给我们 下载进度
    
//downloadProgressDelegate 这个委托中有setProgress 我们重定义它的progress 到我们的model中
    request.downloadProgressDelegate = model;

//downloadProgressDelegate 有一个progress
//    model也有一个progress
//    利用model中的progress 替换ASI中的progress

//断点续传 第一 需要服务器支持
// 断点续传  要告诉服务器从哪个位置下载 rang 发送给服务器的长度是未下载的长度

//下载的临时存储位置 temp  temPath可以是我们自己定义的文件位置
//    尽量不要放在沙盒文件中temp文件内
//    [request setTemporaryFileDownloadPath:temPath];

    [request setCompletionBlock:^{
        NSLog(@"下载成功");
        //弹出提示框 或者做其他操作
        //在这里直接操作 好处是不用来回传值
        //缺点是代码冗余 下载完成状态发送出去 通知 委托 block

    }];

    [request startAsynchronous];

}


-(NSInteger )downLoadFileSize
{
//首先获取文件位置
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents"];

    NSFileManager *fileManagers = [NSFileManager defaultManager];
//不需要获取单个文件 只需要得到documents的大小就行

//枚举  想获取文件  NSEnumerator
//    枚举类型不能直接使用 需要通过其他媒介来使用
//    NSArray  NSSet NSDictionary
//    NSDictionary
    NSDirectoryEnumerator *enumerator = [fileManagers   enumeratorAtPath:path];

    int size = 0;
//获取单个文件 然后才能计算出它的大小
//    enumerator 相当于一个数组

    for (NSString *fileName  in enumerator) {
//获得文件时 要注意 它的文件路径是否正确
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
//        NSLog(@"---%@",filepath);
//        获取文件信息 根据字典可以查看字典大小的方法 得到文件的大小
        NSDictionary *dict  =[fileManagers attributesOfItemAtPath:filepath error:nil];
        size += dict.fileSize;
//        NSLog(@"---%lld",dict.fileSize);
//        size 以B为单位
//        NSLog(@"--%d",size);

    }

    return size;
}


-(void)clearDownLoadFile
{

    //首先获取文件位置
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents"];

    NSFileManager *fileManagers = [NSFileManager defaultManager];
    //不需要获取单个文件 只需要得到documents的大小就行

    //枚举  想获取文件  NSEnumerator
    //    枚举类型不能直接使用 需要通过其他媒介来使用
    //    NSArray  NSSet NSDictionary
    //    NSDictionary
    NSDirectoryEnumerator *enumerator = [fileManagers   enumeratorAtPath:path];


    for (NSString *fileName  in enumerator) {
        //获得文件时 要注意 它的文件路径是否正确
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
//文件管理器可以直接删除文件 根据文件路径
        [fileManagers removeItemAtPath:filepath error:nil];

    }


}






@end
