//
//  YMBaseViewController.m
//  tata_oc
//
//  Created by yongming on 2019/1/17.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMBaseViewController.h"
#import "AppDelegate.h"

@interface YMBaseViewController ()

@end

@implementation YMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

//强制横屏
- (void)forceOrientationLandscape:(BOOL)isForce {
    
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForceLandscape = isForce;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(isForce ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

@end
