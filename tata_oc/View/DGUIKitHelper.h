//
//  DGUIKitHelper.h
//  Douguo
//
//  Created by yongming on 2021/3/15.
//  Copyright © 2021 Douguo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UIKit 助手
@interface DGUIKitHelper : NSObject

/// 生成label
/// @param font 字体
/// @param textColor 文字颜色
/// @param alignment 对齐方式
/// @param text 文字内容
/// @param parentView 父视图
/// @param constraintBlock 适配block
+ (UILabel*)labelWithFont:(UIFont*)font textColor:(UIColor*)textColor alignment:(NSTextAlignment)alignment text:(NSString*)text parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

/// 生成文字button
/// @param font 字体
/// @param titleColor 标题颜色
/// @param backgroundColor 背景色
/// @param cornerRadius 圆角
/// @param title 标题
/// @param parentView 父视图
/// @param constraintBlock 适配block
/// @param target 响应者
/// @param touchAction 响应函数
+ (UIButton*)buttonWithFont:(UIFont*)font titleColor:(UIColor*)titleColor backgroundColor:(UIColor*)backgroundColor cornerRadius:(CGFloat)cornerRadius title:(NSString*)title parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock target:(id)target touchAction:(SEL)touchAction;

/// 生成图像button
/// @param image 图像
/// @param cornerRadius 圆角
/// @param parentView 父视图
/// @param constraintBlock 适配
/// @param target 响应者
/// @param touchAction 响应函数
+ (UIButton*)buttonWithImage:(UIImage*)image cornerRadius:(CGFloat)cornerRadius parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock target:(id)target touchAction:(SEL)touchAction;

/// 生成imageView
/// @param image 初始图像
/// @param parentView 父视图
/// @param constraintBlock 适配block
+ (UIImageView*)imageViewWithImage:(UIImage*)image parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

/// 生成textFiled
/// @param text 文本
/// @param placeHolder 默认文本
/// @param font 字体
/// @param parentView 父视图
/// @param constraintBlock 适配block
+ (UITextField*)textFieldWithText:(NSString*)text placeHolder:(NSString*)placeHolder font:(UIFont*)font parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

/// 生成collectionView
/// @param scrollDirection 布局方向
/// @param lineSpacing 行间距
/// @param interSpacing 间距
/// @param itemSize cell大小
/// @param parentView 父视图
/// @param constraintBlock 适配block
+ (UICollectionView*)collectionViewWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection lineSpacing:(CGFloat)lineSpacing interSpacing:(CGFloat)interSpacing itemSize:(CGSize)itemSize parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

/// 生成导航按钮
/// @param image 图像
/// @param target 响应者
/// @param sel 回调函数
+ (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)image target:(id)target sel:(SEL)sel;

/// 生成View
/// @param color 背景色
/// @param parentView 父视图
/// @param constraintBlock 适配block
+ (UIView*)viewWithColor:(UIColor*)color parentView:(UIView*)parentView constraintBlock:(void(^)(MASConstraintMaker *make))constraintBlock;

/// 添加View的点击事件
/// @param view 目标View
/// @param target 响应者
/// @param sel 响应函数
+ (void)addGestureToTargetView:(UIView*)view target:(id)target sel:(SEL)sel;

/// 添加渐变
/// @param view 目标视图
/// @param frame 目标视图位置
/// @param startPoint 起点
/// @param endPoint 重点
/// @param colors 过渡色数组
+ (void)addGradientOnView:(UIView*)view frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint colors:(NSArray*)colors;

@end

NS_ASSUME_NONNULL_END
