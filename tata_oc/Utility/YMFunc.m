//
//  YMFunc.m
//  tata_oc
//
//  Created by yongming on 2018/9/26.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMFunc.h"

@implementation YMFunc

+ (id)callFromClass:(Class)class selector:(SEL)selector target:(id)target params:(NSArray*)params
{
    NSMethodSignature *methodSignature = [class instanceMethodSignatureForSelector:selector];
    if(methodSignature == nil)
    {
        NSLog(@"call method failed:%@", NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    //签名中方法参数的个数，内部包含了self和_cmd，所以参数从第3个开始
    NSInteger  signatureParamCount = methodSignature.numberOfArguments - 2;
    NSInteger requireParamCount = params.count;
    NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
    for (NSInteger i = 0; i < resultParamCount; i++) {
        id  obj = params[i];
        [invocation setArgument:&obj atIndex:i+2];
    }
    [invocation invoke];
    
    //获得返回值类型
    const char *returnType = methodSignature.methodReturnType;
    //声明返回值变量
    id returnValue;
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if(!strcmp(returnType, @encode(void)) ){
        returnValue = nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if(!strcmp(returnType, @encode(id)) ){
        [invocation getReturnValue:&returnValue];
    }
    else{
        //返回值长度
        NSUInteger length = [methodSignature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        
        //以下代码为参考:具体地址我忘记了，等我找到后补上，(很对不起原作者)
        if (!strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if (!strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }
        else if (!strcmp(returnType, @encode(CGFloat)) ){
#if defined(__LP64__) && __LP64__
            returnValue = [NSNumber numberWithDouble:*((double*)buffer)];
#else
            returnValue = [NSNumber numberWithFloat:*((float*)buffer)];
#endif
        }
    }
    
    return returnValue;
}

@end
