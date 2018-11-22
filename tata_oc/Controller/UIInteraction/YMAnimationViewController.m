//
//  YMAnimationViewController.m
//  tata_oc
//
//  Created by yongming on 2018/10/25.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAnimationViewController.h"

@interface YMAnimationViewController ()
@property (nonatomic, strong) UIButton* eggButton;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIView* testView;
@end

@implementation YMAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.eggButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.eggButton setAdjustsImageWhenHighlighted:NO];
    [self.view addSubview:self.eggButton];
    [self.eggButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [self.eggButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableArray* images = [NSMutableArray array];
    for (int i = 0; i < 19; i ++) {
        NSString* name = [NSString stringWithFormat:@"egg_action_%d", (i+1)];
        NSLog(@"%@", name);
        UIImage* image = [UIImage imageNamed:name];
        if (image)
            [images addObject:image];
    }
    
    
    UIImageView* img = [UIImageView new];
    img.image = images[0];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.eggButton);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    img.animationImages = images;
    img.animationDuration = images.count * .1;
    img.animationRepeatCount = 0;
    [img startAnimating];
    
    self.imageView = img;
    
    self.testView = [UIView new];
    self.testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testView];
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(200);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)buttonClicked
{
//    if (self.imageView.isAnimating)
//    {
//        [self.imageView stopAnimating];
//    } else {
//        [self.imageView startAnimating];
//    }
    
    static BOOL show = YES;
    [self showWithAnimation:show view:self.testView];
    show = !show;
}

- (void)showWithAnimation:(BOOL)show view:(UIView*)view
{
    if (show) {
        view.hidden = NO;
    }
    
    [UIView animateWithDuration:3 animations:^{
        if (show) {
            view.alpha = 1;
        } else {
            view.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (show) {
            
        } else {
            view.hidden = YES;
        }
    }];
}

@end
