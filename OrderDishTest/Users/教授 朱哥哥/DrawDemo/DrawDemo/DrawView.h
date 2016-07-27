//
//  DrawView.h
//  DrawDemo
//
//  Created by 邓鹏飞 on 16/3/31.
//  Copyright © 2016年 lxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

@property (nonatomic) CGPoint movePoint;

@property (nonatomic,strong) NSTimer *timer;

@end
