//
//  YMSafeAreaViewController.m
//  tata_oc
//
//  Created by yongming on 2018/9/11.
//  Copyright © 2018年 yongming. All rights reserved.
//

#import "YMSafeAreaViewController.h"

@interface YMSafeAreaViewController ()

@end

@implementation YMSafeAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.safeAreaInsets.top = 44;

    self.view.backgroundColor = [UIColor blackColor];
    
    UIView* view = [UIView new];
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"viewDidLayoutSubviews... ");
}

@end
