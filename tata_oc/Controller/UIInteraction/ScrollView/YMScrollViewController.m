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
#import "JLAnchorPageScrollViewAgent.h"
#import "YMLeftTableViewController.h"
#import "YMRightTableViewController.h"

@interface YMScrollViewController () <UIScrollViewDelegate>
{
    BOOL _hasScroll;
    BOOL _hasSubScroll;
}

@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) UIScrollView* leftView;
@property (nonatomic, strong) UIScrollView* rightView;
@property (nonatomic, strong) JLAnchorPageScrollViewAgent* scrollAgent;
@property (nonatomic, strong) YMLeftTableViewController* lViewVC;
@property (nonatomic, strong) YMRightTableViewController* rViewVC;

@end

@implementation YMScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
 
//    [self testAutoScrollView];
//    [self testIntegrate];
    
    [self testEasyLayout];
}

- (void)testEasyLayout {
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    
    UIView* view1 = [[UIView alloc] init];
    [scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(600);
        make.width.mas_equalTo(kScreenWidth);
    }];
    view1.backgroundColor = [UIColor redColor];
    
    UIView* view2 = [[UIView alloc] init];
    [scrollView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(600);
        make.top.equalTo(view1.mas_bottom);
        make.width.mas_equalTo(kScreenWidth);
    }];
    view2.backgroundColor = [UIColor greenColor];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.bottom.mas_equalTo(-100);
        make.bottom.equalTo(view2.mas_bottom);
    }];
    
    
    [self addTestButton:view1 tag:10];
    [self addTestButton:view2 tag:11];
}

- (void)addTestButton:(UIView*)parentView tag:(NSInteger)tag {
    UIButton* testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButton setTitle:@"测试按钮" forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor blueColor];
    testButton.tag = tag;
    
    [parentView addSubview:testButton];
    
    [testButton addTarget:self action:@selector(testButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)testButtonClicked:(UIButton*)button {
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"测试内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction* action2 = [UIAlertAction actionWithTitle:@"测试内容2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction* action3 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController* alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"测试提示" preferredStyle:(button.tag == 10) ? UIAlertControllerStyleAlert : UIAlertControllerStyleActionSheet];
    [alertViewController addAction:action];
    [alertViewController addAction:action2];
    [alertViewController addAction:action3];
    
    [self presentViewController:alertViewController animated:YES completion:^{
            
    }];
    
}

/**
 通过约束实现scroll布局
 */
- (void)testAutoScrollView
{
    YMScrollView* scroll = [YMScrollView new];
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    [self.view addSubview:scroll];
    
    UIView* container = [UIView new];
    [scroll addSubview:container];
    
    UITableView* left = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [container addSubview:left];
    
    UITableView* right = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [container addSubview:right];
    
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-100);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.height.equalTo(scroll);
    }];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.equalTo(container);
        make.width.equalTo(scroll);
    }];
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right);
        make.top.bottom.equalTo(container);
        make.width.equalTo(scroll);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(right.mas_right);
    }];
    
    scroll.backgroundColor = [UIColor redColor];
    container.backgroundColor = [UIColor yellowColor];
    left.backgroundColor = [UIColor greenColor];
    right.backgroundColor = [UIColor cyanColor];
}


/**
 联动scrollview测试
 */
- (void)testIntegrate
{
    self.scrollAgent = [[JLAnchorPageScrollViewAgent alloc] init];
    
    self.lViewVC = [[YMLeftTableViewController alloc] init];
    self.rViewVC = [[YMRightTableViewController alloc] init];
    
    CGFloat headerHeight = [UIScreen mainScreen].bounds.size.width + 155;
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, headerHeight)];
    headerView.backgroundColor = [UIColor redColor];
    
    [self addChildViewController:self.lViewVC];
    [self addChildViewController:self.rViewVC];
    
    self.scrollAgent.leftVC = self.lViewVC;
    self.scrollAgent.rightVC = self.rViewVC;
    
    [self.scrollAgent setupAgent:self.view
                        leftView:self.lViewVC.tableView
                       rightView:self.rViewVC.tableView
                      headerView:headerView
                    headerHeight:headerHeight];
}


/**
 测试多ScrollView联动
 */
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
