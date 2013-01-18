//
//  YILogHook.h
//  YILogHook
//
//  Created by Inami Yasuhiro on 13/01/18.
//  Copyright (c) 2013年 Yasuhiro Inami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YILogHookBlock)(NSString* message);

@interface YILogHook : NSObject

+ (void)install;

+ (void)addBlock:(YILogHookBlock)block;
+ (void)removeBlock:(YILogHookBlock)block;

@end
