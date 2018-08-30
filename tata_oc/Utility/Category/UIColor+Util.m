//
//  UIColor+Util.m
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

+ (UIColor*)randomColor
{
    CGFloat r = arc4random() % 255;
    CGFloat g = arc4random() % 255;
    CGFloat b = arc4random() % 255;
    return [UIColor colorWithRed:(r * 1.0 / 255.0) green:(g * 1.0 / 255.0) blue:(b * 1.0 / 255.0) alpha:1];
}

@end
