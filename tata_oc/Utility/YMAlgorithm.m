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

@end
