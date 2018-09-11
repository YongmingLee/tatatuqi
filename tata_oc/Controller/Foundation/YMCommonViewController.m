//
//  YMCommonViewController.m
//  tata_oc
//
//  Created by yongming on 2018/8/29.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMCommonViewController.h"

typedef void (^TestBlock)(int);

@interface YMCommonViewController ()

@property (nonatomic, strong)NSString* name;
@property (nonatomic, copy) TestBlock bb;
@property (nonatomic, copy) NSString* copydString;
@property (nonatomic, strong) NSString* strongString;
@property (nonatomic, strong) NSArray* strongArray;
@property (nonatomic, copy) NSArray* copydArray;

@property (nonatomic, strong) NSTimer* scrollTimer;

@end

@implementation YMCommonViewController

- (void)dealloc
{
    NSLog(@"%@ %@...",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}



/**
 当strong，copy 赋值不是可变类型，结果是一致的。反之，strong是指针引用，copy是新申请内存。
 */
- (void)testCopy
{
    NSMutableString* abc = [[NSMutableString alloc] init];
    
    self.strongString = abc;
    self.copydString = abc;
    
    [abc appendString:@"asdf"];
    
    
    NSArray* s = @[@""];
//    NSMutableArray* s1 = [s copy];
    NSMutableArray* s2 = [s mutableCopy];
    
//    [s addObject:@"4"]; // copy 后的不是mutable类型
    [s2 addObject:@"sdf"];
    
    
    self.strongArray = s2;
    self.copydArray = s2;
    
    [s2 addObject:@"def"];

    NSLog(@"");
}

/**
 测试循环引用：self强引用了block，block 引用了self的属性
 */
- (void)testBlockCyclicReference
{
    // weak 避免循环引用
    __weak YMCommonViewController* weakself = self;
    TestBlock aa = ^(int n) {
        NSLog(@"n:%d", n);
        weakself.name = @"asdfasdf";
    };
    
    self.name = @"";
    
    aa(10);
    
    self.bb = aa;
    
    aa(12);
    
    [self setBb:^(int c) {
        NSLog(@"c:%d", c);
    }];
    
    aa(112);
    
    self.bb(19);
}


/**
 #如果定时器的运行模式是:NSDefaultRunLoopMode，如果界面上又有继承于UIScrollView的控件，
 当我们拖拽时，就自动进入RunLoop的界面追踪模式(UITrackingRunLoopMode)了，
 而NSTimer的运行模式又是默认的运行模式，所以NSTimer就停止运行了
 
 只需设置NSTimer的运行模式为追踪模式
 [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
 
 方法1.最笨的方法是将Timer添加两次--就是两种运行模式都添加一次
 [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
 [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode]
 
 方法2.NSRunLoopCommonModes用这种运行模式就相当于上面两个都添加了
 
 */
- (void)testScrollViewTimer
{
    UIScrollView* scroll = [[UIScrollView alloc] init];
    CGRect frame = self.view.bounds;
    scroll.frame = frame;
    scroll.contentSize = CGSizeMake(frame.size.width, frame.size.height * 4);
    [self.view addSubview:scroll];
    
    scroll.backgroundColor = [UIColor lightGrayColor];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
    label.text = @"This is a label";
    [scroll addSubview:label];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimerHandler) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scrollTimerHandler
{
    NSLog(@"scroll timer alive ...");
}

@end
