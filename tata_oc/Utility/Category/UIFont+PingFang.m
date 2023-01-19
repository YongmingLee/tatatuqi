//
//  UIFont+PingFang.m
//  Douguo
//
//  Created by yongming on 2017/4/18.
//  Copyright © 2017年 Douguo. All rights reserved.
//

#import "UIFont+PingFang.h"

@implementation UIFont (PingFang)
+(UIFont *)pingfangMediumFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Medium" font:size bold:NO];
}
+(UIFont *)pingfangRegularFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Regular" font:size bold:NO];
}
+(UIFont *)pingfangSemiboldFont:(CGFloat)size {
    return [UIFont fontWithName:@"PingFangSC-Semibold" font:size bold:NO];
}

+(UIFont *)pingfangMediumFont:(CGFloat)size bold:(BOOL)blod {
    return [UIFont fontWithName:@"PingFangSC-Medium" font:size bold:blod];
}
+(UIFont *)pingfangRegularFont:(CGFloat)size bold:(BOOL)blod {
    return [UIFont fontWithName:@"PingFangSC-Regular" font:size bold:blod];
}

+(UIFont *)pingfangSemiboldFont:(CGFloat)size bold:(BOOL)blod {
    return [UIFont fontWithName:@"PingFangSC-Semibold" font:size bold:bold];
}

+(UIFont *)fontWithName:(NSString *)name font:(CGFloat)size bold:(BOOL)blod {
    return [UIFont fontWithName:name size:size] ? : blod ? [UIFont boldSystemFontOfSize:size] : [UIFont systemFontOfSize:size];
}
@end
