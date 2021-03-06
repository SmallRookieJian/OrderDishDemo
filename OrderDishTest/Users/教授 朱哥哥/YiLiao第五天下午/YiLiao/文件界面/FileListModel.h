//
//  FileListModel.h
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>
//设置一个枚举类型 用来标记下载状态
typedef enum :NSUInteger
{
    FileModelUnDownLoad = 0,
    FileModelDownLoading,
    FileModelDownLoaded,

}FileModelDownLoadType;


@protocol FileInfoModelDelegate <NSObject>

-(void)downLoadProgress:(float)progress;

@end


@interface FileInfoModel : NSObject

@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSString *url; //下载地址
//description 不能直接使用  因为会替换掉NSobject中的description

@property (nonatomic,strong) NSString *fileDescription;
@property (nonatomic,strong) NSString *tname;

@property (nonatomic,strong) NSNumber *type;


@property (nonatomic,assign) FileModelDownLoadType downLoadType;

@property (nonatomic,unsafe_unretained) id<FileInfoModelDelegate>delegate;
@property (nonatomic) float progress;

-(id)initWithItem:(NSDictionary *)item;

@end








@interface FileListModel : NSObject

//保存数组对象
//保存 FileInfoModel对象
@property (nonatomic,strong) NSArray *pub_file;
@property (nonatomic,strong) NSArray *per_file;


-(id)initWithItem:(NSDictionary *)item;








@end
