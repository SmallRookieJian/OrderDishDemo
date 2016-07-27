//
//  FileManager.h
//  YiLiao
//
//  Created by Mega on 16/3/23.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileListModel.h"

@interface FileManager : NSObject

+(FileManager *)sharManager;

//下载文件  需要传入文件信息model
-(void)downLoadFile:(FileInfoModel *)model;
//获取本地文件是否存在
-(NSString *)downLoadFileWithUrl:(FileInfoModel *)model;














@end
