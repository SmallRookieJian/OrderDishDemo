//
//  Config.m
//
//
//  Created by     on 2010-4-18
//  Email:   --- at--- gmail.com
//  MSN:     --- at--- tom.com
//  Web Home:
//  Copyright 2010   .All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject
{
    NSUserDefaults *defaults;
}

+ (Config *)currentConfig;

#import mark -
@property (nonatomic,copy) NSString *namespace;


@property (readwrite, retain) NSUserDefaults *defaults;

@end
