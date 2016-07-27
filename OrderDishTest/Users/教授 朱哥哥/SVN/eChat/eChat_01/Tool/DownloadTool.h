//
//  DownloadTool.h
//  eChat_01
//
//  Created by mac on 2016/3/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileModel.h"

@interface DownloadTool : NSObject


+ (void)download:(FileModel *)model block:(void (^)(BOOL isSuccess))blockReturn;


@end
