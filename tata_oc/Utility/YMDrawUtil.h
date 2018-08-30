//
//  YMDrawUtil.h
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDrawUtil : NSObject

+ (void)drawLine:(CGPoint)start end:(CGPoint)end context:(CGContextRef)context;
+ (void)drawEllipse:(CGRect)rect context:(CGContextRef)context;

@end
