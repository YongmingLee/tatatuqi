//
//  YMSafeAreaViewController.m
//  tata_oc
//
//  Created by yongming on 2018/9/11.
//  Copyright © 2018年 yongming. All rights reserved.
//

#import "YMSafeAreaViewController.h"

@interface YMSafeAreaViewController ()
@property (nonatomic, strong) NSArray* testViews;
@property (nonatomic, assign) BOOL flag;
@end

@implementation YMSafeAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClicked)];
    [self testVideoLayout];
}

- (void)testVideoLayout {
    CGFloat fWidth = kScreenWidth;
    UIView* containerView = [DGUIKitHelper viewWithColor:[UIColor yellowColor] parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(fWidth * 0.5);
    }];
    
    UIView* other = [DGUIKitHelper viewWithColor:[UIColor blackColor] parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(containerView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    

    UIView* first = [DGUIKitHelper viewWithColor:[UIColor redColor] parentView:containerView constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.top.mas_equalTo(0);
        make.height.equalTo(containerView);
        make.width.equalTo(containerView.mas_height).multipliedBy(1.33);
    }];
    
    UIView* second = [DGUIKitHelper viewWithColor:[UIColor greenColor] parentView:containerView constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(first.mas_right);
        make.right.top.mas_equalTo(0);
        make.height.equalTo(first.mas_height).multipliedBy(0.5);
    }];
    
    UIView* third = [DGUIKitHelper viewWithColor:[UIColor blueColor] parentView:containerView constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.equalTo(first.mas_right);
        make.right.bottom.mas_equalTo(0);
        make.height.equalTo(first.mas_height).multipliedBy(0.5);
    }];
    
    UIView* fourth = [DGUIKitHelper viewWithColor:[UIColor orangeColor] parentView:containerView constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeZero);
    }];
    
    self.testViews = @[containerView, first, second, third, fourth];
}

- (void)rightBarButtonClicked {
    
    [UIView animateWithDuration:.3 animations:^{
        [self updateTestViewLayout];
        [self.view layoutIfNeeded];
    }];
    
    self.flag = !self.flag;
}

- (void)updateTestViewLayout {
    CGFloat fWidth = kScreenWidth;
    UIView* containerView = self.testViews[0];
    UIView* first = self.testViews[1];
    UIView* second = self.testViews[2];
    UIView* third = self.testViews[3];
    UIView* fourth = self.testViews[4];
    
    if (self.flag) {
        [containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(fWidth * 0.5);
        }];
        [first mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.height.equalTo(containerView);
            make.width.equalTo(containerView.mas_height).multipliedBy(1.33);
        }];
        [second mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(first.mas_right);
            make.right.top.mas_equalTo(0);
            make.height.equalTo(first.mas_height).multipliedBy(0.5);
        }];
        [third mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(first.mas_right);
            make.right.bottom.mas_equalTo(0);
            make.height.equalTo(first.mas_height).multipliedBy(0.5);
        }];
        [fourth mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeZero);
        }];
        
    } else {
        
        CGFloat fHeight = fWidth;
        
        [containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(fHeight);
        }];
        
        [first mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.equalTo(containerView);
            make.height.equalTo(first.mas_width).multipliedBy(0.75);
        }];
        [second mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(fWidth*0.33);
            make.top.equalTo(first.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        [third mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(second.mas_right);
            make.width.mas_equalTo(fWidth*0.33);
            make.top.equalTo(first.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
        [fourth mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(third.mas_right);
            make.right.mas_equalTo(0);
            make.top.equalTo(first.mas_bottom);
            make.bottom.mas_equalTo(0);
        }];
    }
}


/**
 测试渐变
 */
- (void)testGradient
{
    UIButton* confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"测试渐变" forState:UIControlStateNormal];
//    [confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
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

@end
