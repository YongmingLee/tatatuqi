//
//  YMDefine.h
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#ifndef YMDefine_h
#define YMDefine_h

#pragma mark - UI 部分

#define UIColorFromHEX(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

#define kWindow ([UIApplication sharedApplication].keyWindow)

#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([UIScreen mainScreen].bounds.size.height)

#define YMRunTime(...) double time0 = CFAbsoluteTimeGetCurrent() * 1000; \
__VA_ARGS__; \
double t = CFAbsoluteTimeGetCurrent() * 1000 - time0; \
NSLog(@"[%s]-time consumed miliseconds:%f", __func__, t);

#define YMRunInMainThread(...) \
if ([NSThread isMainThread]) { \
__VA_ARGS__; \
} else { \
dispatch_async(dispatch_get_main_queue(), ^{ \
__VA_ARGS__; \
}); \
}

#pragma mark - 逻辑部分

#define WS  __weak __typeof(&*self)weakSelf = self;
#define SS __weak __typeof(&*weakSelf)strongSelf = weakSelf;

#endif /* YMDefine_h */
