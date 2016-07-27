//
//  FileListModel.m
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileListModel.h"
@implementation  FileInfoModel

-(id)initWithItem:(NSDictionary *)item
{
    self = [super init];
    if (self ) {
        _image_url = item[@"image_url"];
        _url = item[@"url"];
        _fileDescription = item[@"descripiton"];
        _tname = item[@"tname"];

    }
    return self;

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
