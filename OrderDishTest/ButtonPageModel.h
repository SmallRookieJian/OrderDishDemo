//
//  ButtonPageModel.h
//  OrderDishTest
//
//  Created by mac on 2016/4/9.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BmobObject;
@interface ButtonPageModel : NSObject


@property (nonatomic, copy) NSString *kind;
@property (nonatomic, strong) NSArray *arrTableHeaderNames;
@property (nonatomic, strong) NSURL *urlImage;
@property (nonatomic, strong) NSURL *urlHImage;
@property (nonatomic, strong) NSURL *urlPageTitleImage;


- (id)initWithBmobObject:(BmobObject *)object;


@end
