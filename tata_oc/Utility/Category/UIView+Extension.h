//
//  UIView+Extension.h
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;


/**
 添加四个圆角
 @param radius 半径
 */
- (void)addRoundCorner:(CGFloat)radius;

/**
 在矩形上添加圆角，可以指定某个角
 @param radius 半径
 @param corners 某个角
 */
- (void)cornerWithRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;

@end
