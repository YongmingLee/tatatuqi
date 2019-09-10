//
//  YMProxy.m
//  tata_oc
//
//  Created by Yongming on 2019/9/10.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMProxy.h"

@interface YMProxy()
@property (nonatomic, weak) id target;
@end

@implementation YMProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    YMProxy* proxy = [[self alloc] initWithTarget:target];
    return proxy;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (self.target) {
        return [self.target methodSignatureForSelector:sel];
    }
    
    return nil;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}

@end
