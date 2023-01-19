//
//  YMRotationViewController.m
//  tata_oc
//
//  Created by yongming on 2021/3/18.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "YMRotationViewController.h"

@interface YMRotationViewController ()
@end

@implementation YMRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DGUIKitHelper addGradientOnView:self.view frame:self.view.frame startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 1) colors:@[(__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor]];
    
    UILabel* label = [DGUIKitHelper labelWithFont:[UIFont pingfangMediumFont:30 bold:YES] textColor:UIColorFromHEX(0x0) alignment:NSTextAlignmentCenter text:@"响应链" parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.size.mas_equalTo(200);
        make.center.equalTo(self.view);
    }];
    label.backgroundColor = [UIColor whiteColor];
    
    [self.view layoutIfNeeded];
    [DGUIKitHelper addGradientOnView:label frame:label.bounds startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 1.0) colors:@[(__bridge id)UIColorFromHEXA(0xFFFF00, .1).CGColor, (__bridge id)UIColorFromHEXA(0xFFFF00, 1.0).CGColor]];
    
    [label addRoundCorner:9];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBarClicked)];
}

- (void)rightBarClicked {
    static NSInteger i = 0;
    BOOL flag = (i % 2 == 0);
    [self forceOrientationLandscape:flag];
    i ++;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self forceOrientationLandscape:NO];
}

@end
