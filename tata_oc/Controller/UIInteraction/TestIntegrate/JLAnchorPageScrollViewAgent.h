//
//  JLAnchorPageScrollViewAgent.h
//  呱呱直播
//
//  Created by yongming on 2018/9/25.
//  Copyright © 2018年 com.julelive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JLAnchorPageScrollViewAgentDelegate.h"

@interface JLAnchorPageScrollViewAgent : NSObject

@property (nonatomic, weak) id<JLAnchorPageScrollViewAgentDelegate>leftVC;
@property (nonatomic, weak) id<JLAnchorPageScrollViewAgentDelegate>rightVC;

- (void)setupAgent:(UIView*)parentView
          leftView:(UITableView *)leftView
         rightView:(UITableView *)rightView
        headerView:(UIView*)headerView
      headerHeight:(CGFloat)headerHeight;

@end

