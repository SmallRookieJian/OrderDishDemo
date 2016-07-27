//
//  NSString+MD5.h
//  YiChatDemo41
//
//  Created by 1 on 15/9/15.
//  Copyright (c) 2015年 Mega. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


//类目（类别）

@interface NSString (MD5)
-(NSString *) md5HexDigest;


@end
