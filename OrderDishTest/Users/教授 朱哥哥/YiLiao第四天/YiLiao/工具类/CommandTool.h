//
//  CommandTool.h
//  YiLiao
//
//  Created by MrCheng on 16/3/15.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandTool : NSObject

//跳转主界面
+ (void)goToMainViewController;
//计算文本高度
+ (CGRect)getTextRectWithString:(NSString *)str withWidth:(NSInteger)width withFontSize:(NSInteger)size;

@end
