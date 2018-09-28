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

    self.view.backgroundColor = [UIColor blackColor];
    
    UIView* view = [UIView new];
    view.tag = 10;
    [self.view addSubview:view];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView* view = [self.view viewWithTag:10];
    view.layer.anchorPoint = CGPointMake(0, 0);
    
    [UIView animateWithDuration:1 animations:^{
        
        view.transform = CGAffineTransformRotate(view.transform, 3.14/3); //CGAffineTransformMakeRotation(3.14/3);
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
