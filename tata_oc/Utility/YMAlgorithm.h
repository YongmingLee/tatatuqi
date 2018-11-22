//
//  YMAlgorithm.h
//  tata_oc
//
//  Created by yongming on 2018/8/29.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _YMABinaryTree
{
    struct _YMABinaryTree* left;
    struct _YMABinaryTree* right;
    CGPoint centerPt;
    CGRect rect;
    
} YMABinaryTree;


/**
 算法
 */
@interface YMAlgorithm : NSObject


/**
 生成全二叉树

 @param level 层级数
 @param node 初始节点
 */
- (void)walkBinaryTree:(int)level node:(YMABinaryTree*)node;


/**
 释放二叉树

 @param node 初始节点
 */
- (void)releaseBinaryTree:(YMABinaryTree*)node;




/**
 翻转字符串

 @param sourceString 源字符串
 @return 经过翻转的字符串
 */
- (NSString*)reverseString:(NSString*)sourceString;



/**
 冒泡排序

 @param sourceString string
 @return result
 */
- (NSString*)bubbleSort:(NSString*)sourceString;


/**
 快速排序

 @param sourceString string
 @return result
 */
- (NSString*)quickSort:(NSString*)sourceString;

@end
