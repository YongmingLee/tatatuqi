//
//  YMTabBar.m
//  tata_oc
//
//  Created by yongming on 2021/10/29.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "YMTabBar.h"

@implementation YMTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews {
    NSLog(@"layout....tabbar");
}

- (void)setupshadowColor {
    UIView * tmpView = self;
    tmpView.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    tmpView.layer.shadowOpacity = 0.08;//设置阴影的透明度
    tmpView.layer.shadowOffset = CGSizeMake(0, 0);//设置阴影的偏移量,阴影的大小，x往右和y往下是正
    tmpView.layer.shadowRadius = 5;//设置阴影的圆角,//阴影的扩散范围，相当于blur radius，也是shadow的渐变距离，从外围开始，往里渐变shadowRadius距离

    //去掉TabBar的顶部黑线
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
}


@end
