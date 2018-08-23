//
//  MyScrollView.m
//  tata_oc
//
//  Created by yongming on 2018/8/22.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMScrollView.h"

@implementation YMScrollView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
