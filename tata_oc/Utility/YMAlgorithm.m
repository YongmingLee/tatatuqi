//
//  YMAlgorithm.m
//  tata_oc
//
//  Created by yongming on 2018/8/29.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAlgorithm.h"

static CGFloat OFFSET_X = 25;
static CGFloat OFFSET_Y = 25;
static CGFloat RADIUS = 5;

@implementation YMAlgorithm

- (void)walkBinaryTree:(int)level node:(YMABinaryTree*)node
{
    if (level == 0) return;
    
    YMABinaryTree* left = malloc(sizeof(YMABinaryTree));
    YMABinaryTree* right = malloc(sizeof(YMABinaryTree));
    
    memset(left, 0, sizeof(YMABinaryTree));
    memset(right, 0, sizeof(YMABinaryTree));
    
    node->left = left;
    node->right = right;
    
    left->centerPt = CGPointMake(node->centerPt.x - OFFSET_X, node->centerPt.y + OFFSET_Y);
    right->centerPt = CGPointMake(node->centerPt.x + OFFSET_X, node->centerPt.y + OFFSET_Y);
    
    left->rect = CGRectMake(left->centerPt.x - RADIUS, left->centerPt.y - RADIUS, RADIUS*2, RADIUS*2);
    right->rect = CGRectMake(right->centerPt.x - RADIUS, right->centerPt.y - RADIUS, RADIUS*2, RADIUS*2);
    
    [self walkBinaryTree:(level - 1) node:left];
    [self walkBinaryTree:(level - 1) node:right];
}

- (void)releaseBinaryTree:(YMABinaryTree *)node
{
    if (node->left)
        [self releaseBinaryTree:node->left];
    
    if (node->right)
        [self releaseBinaryTree:node->right];
    
    if (node) {
        free(node);
    }
}

- (NSString*)reverseString:(NSString *)sourceString
{
    // 二分
    NSMutableString* tmp = [NSMutableString stringWithString:sourceString];
    for (int i = 0; i < tmp.length / 2; i ++) {
        NSRange src = NSMakeRange(i, 1);
        NSRange target = NSMakeRange(tmp.length - i - 1, 1);
        
        NSString* srcString = [tmp substringWithRange:src];
        NSString* targetString = [tmp substringWithRange:target];
        
        [tmp replaceCharactersInRange:src withString:targetString];
        [tmp replaceCharactersInRange:target withString:srcString];
    }
    
    return tmp;
}

/**
 交换字符串两个索引的值

 @param sourceString 源字符串
 @param srcIndex 源索引
 @param tarIndex 目标索引
 */
- (void)exchangeStringIndex:(NSMutableString*)sourceString srcIndex:(NSInteger)srcIndex tarIndex:(NSInteger)tarIndex
{
    NSRange src = NSMakeRange(srcIndex, 1);
    NSRange target = NSMakeRange(tarIndex, 1);
    
    NSString* srcString = [sourceString substringWithRange:src];
    NSString* targetString = [sourceString substringWithRange:target];
    
    [sourceString replaceCharactersInRange:src withString:targetString];
    [sourceString replaceCharactersInRange:target withString:srcString];
}

- (NSString*)bubbleSort:(NSString *)sourceString
{
    NSMutableString* mstring = [NSMutableString stringWithString:sourceString];
    
    // 第一种方式，从头开始扫，扫到尾
//    for (NSInteger i = 0; i < mstring.length; i ++) {
//
//        for (NSInteger j = 0; j < mstring.length - 1 - i; j ++) {
//
//            if ([mstring characterAtIndex:j] > [mstring characterAtIndex:(j + 1)]) {
//
//                [self exchangeStringIndex:mstring srcIndex:j tarIndex:(j + 1)];
//            }
//        }
//    }

    
    for (NSInteger i = mstring.length - 1; i >= 0; i --) {
        
        for (NSInteger j = i; j < mstring.length - 1; j ++) {
            
            if ([mstring characterAtIndex:j] > [mstring characterAtIndex:(j + 1)]) {
                
                [self exchangeStringIndex:mstring srcIndex:j tarIndex:(j + 1)];
            }
        }
    }
    
    return mstring;
}

- (NSString*)quickSort:(NSString *)sourceString
{
    NSMutableString* mstring = [NSMutableString stringWithString:sourceString];
    return mstring;
}

@end
