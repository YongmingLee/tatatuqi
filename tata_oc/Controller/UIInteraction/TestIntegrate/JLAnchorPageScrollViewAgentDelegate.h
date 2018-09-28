//
//  YMasdfsadf.h
//  tata_oc
//
//  Created by yongming on 2018/9/26.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JLAnchorPageScrollViewAgentDelegate <NSObject>

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)viewForHeaderInSection:(NSInteger)section;
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (UIView *)viewForFooterInSection:(NSInteger)section;
- (CGFloat)heightForFooterInSection:(NSInteger)section;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
