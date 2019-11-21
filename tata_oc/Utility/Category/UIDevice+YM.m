//
//  UIDevice+YM.m
//  tata_oc
//
//  Created by Yongming on 2019/9/30.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "UIDevice+YM.h"

@implementation UIDevice (YM)

+ (void)disableDarkmode:(UIWindow*)window {
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if(@available(iOS 13.0,*)){
        window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
#endif
}

@end
