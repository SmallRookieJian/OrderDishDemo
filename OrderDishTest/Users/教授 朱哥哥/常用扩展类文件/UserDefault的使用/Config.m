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

#import "Config.h"

@implementation Config

@synthesize defaults;

- (id)init
{
    if (!(self = [super init]))
    {
        return self;
    }


    _name = nil;

    self.defaults = [NSUserDefaults standardUserDefaults];

    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:

    nil]];

    return self;
}

+ (Config *)currentConfig
{
    static dispatch_once_t once;
    static Config         *__singleton__;

    dispatch_once(&once, ^{__singleton__ = [[Config alloc] init]; });
    return __singleton__;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"])
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }

    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *selector = NSStringFromSelector(anInvocation.selector);

    if ([selector hasPrefix:@"set"])
    {
        NSRange firstChar, rest;
        firstChar.location = 3;
        firstChar.length = 1;
        rest.location = 4;
        rest.length = selector.length - 5;

        selector = [NSString stringWithFormat:@"%@%@",
            [[selector substringWithRange:firstChar] lowercaseString],
            [selector substringWithRange:rest]];

        id value;
        [anInvocation getArgument:&value atIndex:2];

        if ([value isKindOfClass:[NSArray class]])
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
    }
    else
    {
        id value = [self.defaults objectForKey:selector];

        if ([value isKindOfClass:[NSData class]])
        {
            value = [NSKeyedUnarchiver unarchiveObjectWithData:value];
        }

        [anInvocation setReturnValue:&value];
    }
}

@end
