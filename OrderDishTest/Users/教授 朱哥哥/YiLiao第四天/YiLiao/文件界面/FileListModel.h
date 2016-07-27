//
//  FileListModel.h
//  YiLiao
//
//  Created by Mega on 16/3/22.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfoModel : NSObject

@property (nonatomic,strong) NSString *image_url;
@property (nonatomic,strong) NSString *url;
//description 不能直接使用  因为会替换掉NSobject中的description

@property (nonatomic,strong) NSString *fileDescription;
@property (nonatomic,strong) NSString *tname;

-(id)initWithItem:(NSDictionary *)item;


@end



@interface FileListModel : NSObject

//保存数组对象
//保存 FileInfoModel对象
@property (nonatomic,strong) NSArray *pub_file;
@property (nonatomic,strong) NSArray *per_file;


-(id)initWithItem:(NSDictionary *)item;








@end
