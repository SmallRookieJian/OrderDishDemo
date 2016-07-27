//
//  DownloadTool.m
//  eChat_01
//
//  Created by mac on 2016/3/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DownloadTool.h"

#import "UIImageView+WebCache.h"

@implementation DownloadTool
/*
 enum Filetype {
 PDF,
 MP3,
 MP4,
 DOC,
 JPG,
 };

 */


+ (void)download:(FileModel *)model block:(void (^)(BOOL isSuccess))blockReturn {
    
    enum Filetype type = model.type;
    
    switch (type) {
        case PDF:
        {
            NSLog(@"你好，点了PDF");
            [self isDirectoryExist:@"PDF"];
            
            
            
        }
            break;
        case MP3:
        {
            NSLog(@"你好，点了MP3");
            [self isDirectoryExist:@"MP3"];
        }
            break;
        case MP4:
        {
            NSLog(@"你好，点了MP4");
            [self isDirectoryExist:@"MP4"];
        }
            break;
        case DOC:
        {
            NSLog(@"你好，点了DOC");
            [self isDirectoryExist:@"DOC"];
        }
            break;
        case JPG:
        {
            NSLog(@"要下载图片了");
            [self isDirectoryExist:@"JPG"];
            NSURL *url = [NSURL URLWithString:model.url];
            [self downloadJPG:url WithImgName:model.name block:^(BOOL isSuccess) {
                blockReturn(isSuccess);
            }];
        }
            break;
            
        default:
            break;
    }
    
}

+ (void)downloadFDBAndDOC:(NSURL *)url WithName:(NSString *)name block:(void (^)(BOOL isSuccess))blockReturn {
    
    
    
    
}

+ (void)downloadJPG:(NSURL *)url WithImgName:(NSString *)name block:(void (^)(BOOL isSuccess))blockReturn {
    
    NSLog(@"%@",NSHomeDirectory());
    
    UIImageView *imgView = [[UIImageView alloc] init];
    
    [imgView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        NSLog(@"-------------------你走吧");
        
#warning 在这里怎么点两次才能将图片存储到本地？？？？也不是图片加载需要时间的问题啊。。。
        //已经取得了图片，先检查图片在Documents中有没有，没有的话再存入Documents
        NSData *dataImg = UIImageJPEGRepresentation(image, 0.5);
        
        NSLog(@"dataImg---->>>>%@",dataImg);
        
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/Images/%@",name]];
        if ([dataImg writeToFile:path atomically:YES]) {
            NSLog(@"存储成功了");
            
            blockReturn(YES);
            
        }
        else {
            
            NSLog(@"存储失败");
            blockReturn(NO);
        }
        
        
    }];
    
}

/**
 *  判断某种类型的文件夹是否存在,不存在则创建
 *
 *  @param type 对应的媒体类型
 */
+ (void)isDirectoryExist:(NSString *)type {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docPath stringByAppendingPathComponent:type];
    if ([manager fileExistsAtPath:path]) {
        return;
    }
    else {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}


@end
