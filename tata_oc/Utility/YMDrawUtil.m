//
//  YMDrawUtil.m
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMDrawUtil.h"

@implementation YMDrawUtil

+ (void)drawEllipse:(CGRect)rect context:(CGContextRef)context
{
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathFillStroke);
}

+ (void)drawLine:(CGPoint)start end:(CGPoint)end context:(CGContextRef)context
{
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextStrokePath(context);
}

@end
