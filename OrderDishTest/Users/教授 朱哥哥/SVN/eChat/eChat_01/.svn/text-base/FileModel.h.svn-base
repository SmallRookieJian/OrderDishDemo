//
//  FileModel.h
//  eChat_01
//
//  Created by mac on 2016/3/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileImageModel.h"

enum Filetype {
    PDF,
    MP3,
    MP4,
    DOC,
    JPG,
};



@interface FileModel : NSObject


@property (nonatomic, assign) enum Filetype type;//这是个枚举类型
@property (nonatomic, assign) long long length;
@property (nonatomic, copy) NSString *file_id,*mimetype,*image_url,*url,*name;
@property (nonatomic, copy) NSString *file_description,*author,*tname,*time,*dtimes;
@property (nonatomic, retain) FileImageModel *imageModel;

+ (FileModel *)parserFromDic:(NSDictionary *)dic;
- (id)initFromDic:(NSDictionary *)dic;

@end
