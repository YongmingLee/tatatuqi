//
//  YMAlgorithmDrawView.h
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YMAlgorithmType)
{
    YMAlgoBinaryTree
};

@interface YMAlgorithmDrawView : UIView

@property (nonatomic, assign) YMAlgorithmType algoType;

@end
