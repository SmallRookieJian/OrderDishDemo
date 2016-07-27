//
//  FileListModel.m
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileListModel.h"
#import "FileManager.h"

@implementation  FileInfoModel

-(id)initWithItem:(NSDictionary *)item
{
    self = [super init];
    if (self ) {
        _image_url = item[@"image_url"];
        _url = item[@"url"];
        _fileDescription = item[@"descripiton"];
        _tname = item[@"tname"];
        _type = item[@"type"];

//        添加容错判断  当文件以及下载过以后 progress 需要设置成1

        if (self.downLoadType == FileModelDownLoaded) {
            self.progress = 1;
        }


    }
    return self;

}

//调用属性时 会进入他的set方法
-(void)setProgress:(float)progress
{
//    它的计算是以M为单位
    _progress = progress;

    NSLog(@"---%f",_progress);
    if ([_delegate respondsToSelector:@selector(downLoadProgress:)]) {
        [_delegate downLoadProgress:progress];
    }

}


-(FileModelDownLoadType)downLoadType
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [[FileManager sharManager] downLoadFileWithUrl:self];
    BOOL isExists = [manager fileExistsAtPath:path];

//设置三个状态
    if (isExists) {
        return FileModelDownLoaded;
    }else if(self.progress != 0){
        return FileModelDownLoading;
    }else
    {
        return  FileModelUnDownLoad;
    }

}


@end


@implementation FileListModel

-(id)initWithItem:(NSDictionary *)item
{
    self= [super init];
    if (self) {
//        给公共资源赋值
        NSArray *pubFilArray = item[@"filelist"][@"pub_file"];
        NSMutableArray *pubModelArray =[NSMutableArray array];

        for (NSDictionary *pubItem in pubFilArray) {

            FileInfoModel *fileInfoModel = [[FileInfoModel alloc]initWithItem:pubItem];

            [pubModelArray addObject:fileInfoModel];
        }
//
        _pub_file = pubModelArray;


//给个人资源赋值

        NSArray *perFilArray = item[@"filelist"][@"per_file"];

        NSMutableArray *perModelArray =[NSMutableArray array];

        for (NSDictionary *perItem in perFilArray) {

            FileInfoModel *fileInfoModel = [[FileInfoModel alloc]initWithItem:perItem];
            [perModelArray addObject:fileInfoModel];
        }

        _per_file = perModelArray;
    }
    return self;
}












@end
