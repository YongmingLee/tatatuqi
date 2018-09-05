//
//  YMAlgorithmDrawView.m
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAlgorithmDrawView.h"
#import "YMDrawUtil.h"

@interface YMAlgorithmDrawView()
{
    YMABinaryTree* binaryTree;
}
@property (nonatomic, strong) YMAlgorithm* algo;
@end


@implementation YMAlgorithmDrawView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor orangeColor];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(80, 50));
        }];
        [button setTitle:@"重新生成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTestClicked) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor greenColor];
        
        CGRect bounds = [UIScreen mainScreen].bounds;
        self.algo = [[YMAlgorithm alloc] init];
        
        switch (self.algoType) {
            case YMAlgoBinaryTree:
                {
                    binaryTree = malloc(sizeof(YMABinaryTree));
                    binaryTree->centerPt = CGPointMake(bounds.size.width*.5, 5);
                    binaryTree->rect = CGRectMake(binaryTree->centerPt.x-5, binaryTree->centerPt.y-5, 10, 10);
                    
                    [self.algo walkBinaryTree:12 node:binaryTree];
                }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}

- (void)dealloc
{
    switch (self.algoType) {
        case YMAlgoBinaryTree:
        {
            [self.algo releaseBinaryTree:binaryTree];
        }
            break;
            
        default:
            break;
    }
}

- (void)buttonTestClicked
{
    [self setNeedsDisplay];
}

- (void)drawBinaryNode:(YMABinaryTree*)node context:(CGContextRef)context
{
    if (!node) return;
    
    if (node->left) {
        [YMDrawUtil drawLine:node->centerPt end:node->left->centerPt context:context];
        [self drawBinaryNode:node->left context:context];
    }
    if (node->right) {
        [YMDrawUtil drawLine:node->centerPt end:node->right->centerPt context:context];
        [self drawBinaryNode:node->right context:context];
    }
    
    [YMDrawUtil drawEllipse:node->rect context:context];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor* color = [UIColor randomColor];
    UIColor* colorFill = [UIColor randomColor];
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, colorFill.CGColor);
    
    switch (self.algoType) {
        case YMAlgoBinaryTree:
        {
            [self drawBinaryNode:binaryTree context:context];
        }
            break;
            
        default:
            break;
    }
}


@end
