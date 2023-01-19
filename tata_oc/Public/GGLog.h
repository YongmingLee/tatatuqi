//
//  GGLog.h
//  tata_oc
//
//  Created by yongming on 21-3-19.
//  Copyright (c) 2021年 sadusaga. All rights reserved.
//

#ifndef YM_GGLog_h
#define YM_GGLog_h

/*说明：
 *1.两个log方法，GGLogDebug GGLogError，用法和NSLog一样
 *2.GGLogDebug的输出添加了函数名
 *3.GGLogError的输出添加Error字段，添加了函数名和行号
 */
#ifdef DEBUG
#define GGLogDebug(fmt, ...) NSLog((@"%s" fmt), __FUNCTION__, ##__VA_ARGS__);
#define GGLogError(fmt, ...) NSLog((@"ERROR%s:%d" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define GGLog(fmt,...);

#else
#define GGLogDebug(...);
#define GGLogError(...);
#define GGLog(fmt,...) NSLog((@"%s" fmt), __FUNCTION__, ##__VA_ARGS__);
#endif

#define Weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define Strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop") \
if (!self) {return;}

#endif
