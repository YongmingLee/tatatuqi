//
//  DGUIKitHelper.m
//  Douguo
//
//  Created by yongming on 2021/3/15.
//  Copyright © 2021 Douguo. All rights reserved.
//

#import "DGUIKitHelper.h"

@implementation DGUIKitHelper

+ (UILabel*)labelWithFont:(UIFont*)font textColor:(UIColor*)textColor alignment:(NSTextAlignment)alignment text:(NSString*)text parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock{
    UILabel* label = [[UILabel alloc] init];
    label.textAlignment = alignment;
    label.font = font;
    label.textColor = textColor;
    label.text = text;
    [parentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    
    return label;
}

+ (UIButton*)buttonWithFont:(UIFont*)font titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius title:(NSString*)title parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock target:(id)target touchAction:(SEL)touchAction {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [parentView addSubview:button];
    [button addTarget:target action:touchAction forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    button.backgroundColor = backgroundColor;
    button.layer.cornerRadius = cornerRadius;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    return button;
}

+ (UIButton*)buttonWithImage:(UIImage*)image cornerRadius:(CGFloat)cornerRadius parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock target:(id)target touchAction:(SEL)touchAction {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [parentView addSubview:button];
    [button addTarget:target action:touchAction forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

+ (UIImageView*)imageViewWithImage:(UIImage*)image parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock {
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [parentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    return imageView;
}

+ (UITextField*)textFieldWithText:(NSString*)text placeHolder:(NSString*)placeHolder font:(UIFont*)font parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock {
    UITextField* textFiled = [[UITextField alloc] init];
    [parentView addSubview:textFiled];
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    textFiled.text = text;
    textFiled.placeholder = placeHolder;
    textFiled.font = font;
    return textFiled;
}

+ (UICollectionView*)collectionViewWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection lineSpacing:(CGFloat)lineSpacing interSpacing:(CGFloat)interSpacing itemSize:(CGSize)itemSize parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = scrollDirection;
    flowLayout.minimumLineSpacing = lineSpacing;
    flowLayout.minimumInteritemSpacing = interSpacing;
    flowLayout.itemSize = itemSize;
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [parentView addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    return collectionView;
}

+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)image target:(id)target sel:(SEL)sel {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIView*)viewWithColor:(UIColor*)color parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock {
    UIView* view = [[UIView alloc] init];
    [parentView addSubview:view];
    view.backgroundColor = color;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        constraintBlock(make);
    }];
    return view;
}

+ (void)addGestureToTargetView:(UIView*)view target:(id)target sel:(SEL)sel {
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
}

/**
 CAGradientLayer坐标系统
 从坐标（0，0）到（1，1）绘制的矩形
 
 (0,0) -----------------------(1,0)
  |
  |
  |
  |
  |
  |
 (0,1) -----------------------(1,1)
 */
+ (void)addGradientOnView:(UIView*)view frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = startPoint;
    gl.endPoint = endPoint;
    gl.colors = colors;
    gl.locations = @[@(0), @(1.0f)];
    [view.layer addSublayer:gl];
}

@end
