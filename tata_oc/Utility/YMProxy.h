//
//  YMProxy.h
//  tata_oc
//
//  Created by Yongming on 2019/9/10.
//  Copyright © 2019 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
