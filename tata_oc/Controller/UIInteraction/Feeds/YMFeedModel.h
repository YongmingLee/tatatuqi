//
//  YMFeedModel.h
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/**
 Feed 流的model
 */
@interface YMFeedModel : NSObject

@property (nonatomic, copy) NSString* stringContent;
@property (nonatomic, assign) NSInteger stringHeight;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) BOOL needDraw;

+ (YMFeedModel*)feedWithString:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
