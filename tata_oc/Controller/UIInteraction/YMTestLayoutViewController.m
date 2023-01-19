//
//  YMTestLayoutViewController.m
//  tata_oc
//
//  Created by yongming on 2021/10/22.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "YMTestLayoutViewController.h"

@interface YMTestLayoutViewController ()
@property (nonatomic, strong) YMTestLayoutView* layoutView;
@end

@implementation YMTestLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    YMTestLayoutView* layoutView = [[YMTestLayoutView alloc] init];
    [self.view addSubview:layoutView];
    layoutView.backgroundColor = [UIColor redColor];
    [layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    self.layoutView = layoutView;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(testButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.center.equalTo(self.view);
    }];
}

- (void)testButtonDidClicked {
    [self.layoutView setNeedsLayout];
    [self.layoutView layoutIfNeeded];
}

- (void)viewWillLayoutSubviews {
    NSLog(@"viewWillLayoutSubviews...");
}

- (void)viewDidLayoutSubviews {
    NSLog(@"viewDidLayoutSubviews...");
}

@end

@implementation YMTestLayoutView

- (void)layoutSubviews {
    NSLog(@"YMTestLayoutView:layoutSubviews...");
}

@end
