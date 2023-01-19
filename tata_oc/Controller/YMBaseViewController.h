//
//  YMBaseViewController.h
//  tata_oc
//
//  Created by yongming on 2019/1/17.
//  Copyright © 2019 yongming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMBaseViewController : UIViewController

/// 强制横屏
/// @param isForce 是否强制
- (void)forceOrientationLandscape:(BOOL)isForce;

@end

NS_ASSUME_NONNULL_END
