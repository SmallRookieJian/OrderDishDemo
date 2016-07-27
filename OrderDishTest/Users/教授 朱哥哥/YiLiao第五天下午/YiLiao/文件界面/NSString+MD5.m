//
//  NSString+MD5.m
//  YiChatDemo41
//
//  Created by 1 on 15/9/15.
//  Copyright (c) 2015年 Mega. All rights reserved.
//

#import "NSString+MD5.h"

@implementation NSString (MD5)
-(NSString *) md5HexDigest
{
    
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    利用移位算法
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
//        MD5算法 最终会返还给我们一个 16个字节长度的string
        [hash appendFormat:@"%02X", result[i]];
    
    return [hash lowercaseString];
    
}


@end
