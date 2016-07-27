//
//  ButtonPageModel.m
//  OrderDishTest
//
//  Created by mac on 2016/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ButtonPageModel.h"
#import <BmobSDK/BmobFile.h>

#import <BmobSDK/BmobObject.h>

#import "objc/runtime.h"

@implementation ButtonPageModel

//*kind; *tableHeaderNameArr *urlImage; *urlHImage;

- (id)initWithBmobObject:(BmobObject *)object {
    
    if (self = [super init]) {
        
        NSLog(@"这是第一次取数据尝试：%@",object);
        
        NSMutableArray *allNames = [NSMutableArray array];
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList([object class], &propertyCount);
        
        for (int i = 0; i < propertyCount; i ++) {
            ///取出第一个属性
            objc_property_t property = propertys[i];
            
            const char * propertyName = property_getName(property);
            
            [allNames addObject:[NSString stringWithUTF8String:propertyName]];
        }
        
        free(propertys);
        
        NSLog(@"这是所有的属性%@",allNames);
        
        
        _kind = [object objectForKey:@"kind"];
        
        //在这里得到表中具体的区头名称
        NSString *name = [object objectForKey:@"name"];
        _arrTableHeaderNames = [NSArray arrayWithArray:[name componentsSeparatedByString:@"|"]];
        
        //得到按钮平常状态、高亮状态的图片URL
        BmobFile *fileImage = [object objectForKey:@"image"];
        _urlImage = [NSURL URLWithString:fileImage.url];
        
        BmobFile *fileHImage = [object objectForKey:@"highlighted_image"];
        _urlHImage = [NSURL URLWithString:fileHImage.url];
        
        
        BmobFile *filePageTitleImage = [object objectForKey:@"pageTitleImage"];
        _urlPageTitleImage = [NSURL URLWithString:filePageTitleImage.url];
        
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@,%@,%@",self.kind,self.arrTableHeaderNames,self.urlImage];
}

@end
