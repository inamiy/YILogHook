//
//  YILogHook.m
//  YILogHook
//
//  Created by Inami Yasuhiro on 13/01/18.
//  Copyright (c) 2013年 Yasuhiro Inami. All rights reserved.
//

#import "YILogHook.h"

static NSMutableArray* __hookBlocks = nil;


// http://www.drycarbon.com/marimo/index.rb?room=droom;memo=Objective-C+%3A+NSLog
extern void _NSSetLogCStringFunction(void(*)(const char*, unsigned, BOOL));

static void _YILogCString(const char* message, unsigned length, BOOL withSysLogBanner)
{
    @autoreleasepool {
//        fprintf(stderr, "%s\n", message);
        
        NSString* msg = [NSString stringWithCString:message encoding:NSUTF8StringEncoding];
        
        for (YILogHookBlock hookBlock in __hookBlocks) {
            hookBlock(msg);
        }
    }
}


@implementation YILogHook

+ (void)install
{
    setbuf(stderr, NULL);
    
    // private API: http://support.apple.com/kb/TA45403
    _NSSetLogCStringFunction(_YILogCString);
    
    __hookBlocks = [NSMutableArray array];
}

+ (void)addBlock:(YILogHookBlock)block
{
    [__hookBlocks addObject:block];
}

+ (void)removeBlock:(YILogHookBlock)block
{
    [__hookBlocks removeObject:block];
}

@end