//
//  YMDefine.h
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#ifndef YMDefine_h
#define YMDefine_h

#pragma mark - UI 部分

#define UIColorFromHEX(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

#define kWindow ([UIApplication sharedApplication].keyWindow)

#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([UIScreen mainScreen].bounds.size.height)

#define IS_iPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size): NO)
#define IS_iPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size): NO)
#define IS_iPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size)): NO)
#define IS_iPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208),[[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001),[[UIScreen mainScreen] currentMode].size)): NO)
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)


//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

#define IS_IPHONE_Xr2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)


#define IS_iPhoneX (IS_IPHONE_X || IS_IPHONE_Xr1 || IS_IPHONE_Xr2 || IS_IPHONE_Xs_Max)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kStatusBarHeight (IS_iPhoneX ? 44 : 20)
#define kNavItemBarHeight (kStatusBarHeight + 44)
#define iPhoneXSafeBottom  (IS_iPhoneX ? 34 : 0)
#define StatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTabbarHeight (IS_iPhoneX ? 83 : 49)
#define kNavigationStatusHeight (IS_iPhoneX ? 88 : 64)

#define YMRunTime(...) double time0 = CFAbsoluteTimeGetCurrent() * 1000; \
__VA_ARGS__; \
double t = CFAbsoluteTimeGetCurrent() * 1000 - time0; \
NSLog(@"[%s]-time consumed miliseconds:%f", __func__, t);

#define YMRunInMainThread(...) \
if ([NSThread isMainThread]) { \
__VA_ARGS__; \
} else { \
dispatch_async(dispatch_get_main_queue(), ^{ \
__VA_ARGS__; \
}); \
}

// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

/* 使用示例
 GuaExchangeGemsModel *model = self.dataSource[indexPath.row];
 GGLogDebug(@"%@",model.strBalanceBeans);
 if (model) {
     kPreventRepeatClickTime(1.5);
     if ([QLUserManager shareUserManager].userInforModel.realMoney >= [model.strBalanceBeans integerValue]) {
     [self.currentController showWaitingHUD];
     self.rmbToDiamondApi.userId = QLUserManager.shareUserManager.userInforModel.userID;
     self.rmbToDiamondApi.inmoney = model.strExchangeGems;
     self.rmbToDiamondApi.outMoney = model.strBalanceBeans;
     [self.rmbToDiamondApi sendRMBtoDiamondRq];
 }
 else{
    [self.currentController showWaitingAutoDismissHUDWithText:@"当前账户余额不足"];
 }

 */

#pragma mark - 逻辑部分

#define WS  __weak __typeof(&*self)weakSelf = self;
#define SS __weak __typeof(&*weakSelf)strongSelf = weakSelf;

#endif /* YMDefine_h */
