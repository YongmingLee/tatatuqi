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
    
//    self.title = @"hallo";
    
    UIView* titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor greenColor];
    self.navigationItem.titleView = titleView;
    
    UIView* containerView = [[UIView alloc] init];
    [titleView addSubview:containerView];
    containerView.backgroundColor = [UIColor blueColor];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
    }];
    
    
    UIView* blockView = [[UIView alloc] init];
    blockView.backgroundColor = [UIColor redColor];
    [containerView addSubview:blockView];

    UILabel* titleLabel = [[UILabel alloc] init];
    [containerView addSubview:titleLabel];
    titleLabel.backgroundColor = [UIColor redColor];

    [blockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(-8);
        make.right.mas_equalTo(titleLabel.mas_left).offset(-10);
    }];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blockView.mas_right).offset(10);
        make.centerY.equalTo(blockView);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(0);
    }];
    
    titleLabel.text = @"hello";
}


/**
 测试渐变
 */
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
