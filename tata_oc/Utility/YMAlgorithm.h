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

@interface YMAlgorithm : NSObject

- (void)walkBinaryTree:(int)level node:(YMABinaryTree*)node;
- (void)releaseBinaryTree:(YMABinaryTree*)node;

@end
