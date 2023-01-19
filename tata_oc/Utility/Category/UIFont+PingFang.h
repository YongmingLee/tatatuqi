//
//  UIFont+PingFang.h
//  Douguo
//
//  Created by yongming on 2017/4/18.
//  Copyright © 2017年 Douguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (PingFang)
+(UIFont *)pingfangRegularFont:(CGFloat)size;
+(UIFont *)pingfangMediumFont:(CGFloat)size;
+(UIFont *)pingfangSemiboldFont:(CGFloat)size;
+(UIFont *)pingfangRegularFont:(CGFloat)size bold:(BOOL)blod;
+(UIFont *)pingfangMediumFont:(CGFloat)size bold:(BOOL)blod;
+(UIFont *)pingfangSemiboldFont:(CGFloat)size bold:(BOOL)blod;
@end

