//
//  ViewController2.m
//  tata_oc
//
//  Created by yongming on 2018/6/14.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMScrollViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import "YMScrollView.h"

@interface YMScrollViewController () <UIScrollViewDelegate>
{
    BOOL _hasScroll;
    BOOL _hasSubScroll;
}

@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) UIScrollView* leftView;
@property (nonatomic, strong) UIScrollView* rightView;

@end

@implementation YMScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self testViewLayout];
}

- (void)testViewLayout
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    YMScrollView* container = [[YMScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:container];
    [container setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 200)];
    container.backgroundColor = [UIColor yellowColor];
    container.delegate = self;
    [self setContainerView:container];
    
    UIView* headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [container addSubview:headerView];
    headerView.backgroundColor = [UIColor redColor];
    
    CGRect bounds = self.view.bounds;
    UIScrollView* bottomScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, bounds.size.width, bounds.size.height)];
    [container addSubview:bottomScroll];
    bottomScroll.backgroundColor = [UIColor greenColor];
    [bottomScroll setContentSize:CGSizeMake(bounds.size.width*2, bounds.size.height)];
    
    bottomScroll.pagingEnabled = YES;
    
    {
        UIScrollView* left = [[UIScrollView alloc] initWithFrame:bounds];
        [bottomScroll addSubview:left];
        [left setContentSize:CGSizeMake(bounds.size.width, bounds.size.height*2)];
        left.backgroundColor = [UIColor grayColor];
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
        gradientLayer.locations = @[@0, @0.8];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, bounds.size.width, left.contentSize.height);
        [left.layer addSublayer:gradientLayer];
        
        left.delegate = self;
        
        UIScrollView* right = [[UIScrollView alloc] initWithFrame:CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height)];
        [bottomScroll addSubview:right];
        [right setContentSize:CGSizeMake(bounds.size.width, bounds.size.height*2)];
        right.backgroundColor = [UIColor orangeColor];
        right.delegate = self;
        
        CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
        gradientLayer2.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
        gradientLayer2.locations = @[@0, @0.8];
        gradientLayer2.startPoint = CGPointMake(0, 0);
        gradientLayer2.endPoint = CGPointMake(0, 1.0);
        gradientLayer2.frame = CGRectMake(0, 0, bounds.size.width, left.contentSize.height);
        [right.layer addSublayer:gradientLayer2];
        
        [self setLeftView:left];
        [self setRightView:right];
    }
    
    self.containerView.showsVerticalScrollIndicator = NO;
//    self.leftView.showsVerticalScrollIndicator = NO;
//    self.rightView.showsVerticalScrollIndicator = NO;
//    bottomScroll.showsHorizontalScrollIndicator = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint mainPT = scrollView.contentOffset;
    
    if (scrollView == self.containerView) {
        
        NSLog(@"offset:%@", NSStringFromCGPoint(mainPT));
        
        if (mainPT.y < 200 && !_hasScroll) {
            self.leftView.contentOffset = CGPointMake(0, 0);
            self.rightView.contentOffset = CGPointMake(0, 0);
            [self showContainerIndicator:YES];
        } else {
            self.containerView.contentOffset = CGPointMake(0, 200);
            _hasScroll = YES;
            _hasSubScroll = NO;
            [self showContainerIndicator:NO];
        }
        
    } else if (scrollView == self.leftView || scrollView == self.rightView) {
        
        NSLog(@"====> offset:%@", NSStringFromCGPoint(mainPT));
        
        if (mainPT.y > 0 && !_hasSubScroll && _hasScroll) {
            self.containerView.contentOffset = CGPointMake(0, 200);
            [self showContainerIndicator:NO];
        } else {
            _hasScroll = NO;
            _hasSubScroll = YES;
            [self showContainerIndicator:YES];
        }
    }
}

- (void)showContainerIndicator:(BOOL)show
{
    self.containerView.showsVerticalScrollIndicator = show;
    self.leftView.showsVerticalScrollIndicator = !show;
    self.rightView.showsVerticalScrollIndicator = !show;
}

@end
