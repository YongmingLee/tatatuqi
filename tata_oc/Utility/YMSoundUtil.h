//
//  YMSoundUtil.h
//  tata_oc
//
//  Created by Yongming on 2019/9/30.
//  Copyright © 2019 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/// 声音工具类
@interface YMSoundUtil : NSObject

/// 开始监听音量
/// @param view 宿主View
- (void)startCapturingOnView:(UIView*)view;


/// 停止监听
- (void)stopCapturing;

@end

NS_ASSUME_NONNULL_END
