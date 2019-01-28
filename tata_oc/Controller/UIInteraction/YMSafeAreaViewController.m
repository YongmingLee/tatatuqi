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

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testGradient];
}

- (void)testGradient
{
    UIButton* confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"测试渐变" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CAGradientLayer* bkColorLayer = [CAGradientLayer new];
    bkColorLayer.colors = @[(id)UIColorFromHEX(0xFFF603).CGColor, (id)UIColorFromHEX(0xFCBF04).CGColor];
    
    bkColorLayer.startPoint = CGPointMake(0, .5);
    bkColorLayer.endPoint = CGPointMake(1, .5);
    [confirmButton.layer addSublayer:bkColorLayer];
    [self.view addSubview:confirmButton];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        bkColorLayer.frame = confirmButton.bounds;
    });
}

- (void)confirmButtonClicked
{
    NSLog(@"hello");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}



@end
