//
//  UIImage+YM.m
//  tata_oc
//
//  Created by yongming on 2021/9/26.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "UIImage+YM.h"

@implementation UIImage (YM)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    color = color ? color : [UIColor clearColor];
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextAddRoundRect(context, CGRectMake(0, 0, size.width, size.height), cornerRadius);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 上下文画圆角
/// @param context 上下文
/// @param rect 矩形
/// @param radius 圆角弧度
void CGContextAddRoundRect(CGContextRef context,CGRect rect,CGFloat radius){
    float x1=rect.origin.x;
    float y1=rect.origin.y;
    float x2=x1+rect.size.width;
    float y2=y1;
    float x3=x2;
    float y3=y1+rect.size.height;
    float x4=x1;
    float y4=y3;
    CGContextMoveToPoint(context, x1, y1+radius);
    CGContextAddArcToPoint(context, x1, y1, x1+radius, y1, radius);
    
    CGContextAddArcToPoint(context, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(context, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(context, x4, y4, x4, y4-radius, radius);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径
}

@end
