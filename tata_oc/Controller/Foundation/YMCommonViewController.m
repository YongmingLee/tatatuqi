//
//  YMCommonViewController.m
//  tata_oc
//
//  Created by yongming on 2018/8/29.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMCommonViewController.h"
//#import <YMUtils/YMDeviceUtil.h>
//#import <QMUIKit/QMUIKit.h>

typedef void (^TestBlock)(int);

@interface JLPCTextSubModel : NSObject
@property (nonatomic, strong) NSString* fromtype;
@property (nonatomic, strong) NSString* fromlevel;
@property (nonatomic, strong) NSString* totype;
@property (nonatomic, strong) NSString* tolevel;
@property (nonatomic, strong) NSString* msgtype;
@end
@implementation JLPCTextSubModel
@end

@interface JLPCTextMessageModel : NSObject
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* extra;
@end

@implementation JLPCTextMessageModel
@end


@interface YMCommonViewController ()

@property (nonatomic, strong)NSString* name;
@property (nonatomic, copy) TestBlock bb;
@property (nonatomic, copy) NSString* copydString;
@property (nonatomic, strong) NSString* strongString;
@property (nonatomic, strong) NSArray* strongArray;
@property (nonatomic, copy) NSArray* copydArray;

@property (nonatomic, strong) NSTimer* scrollTimer;
@property (nonatomic, strong) dispatch_semaphore_t sem;
@property (nonatomic, strong) dispatch_queue_t testQueue;

@end

@implementation YMCommonViewController

- (void)dealloc
{
    NSLog(@"%@ %@...",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    YMRunTime(
//              [self testCopy];
//              );
//
//    [YMDeviceUtil printDeviceName];
    
    
//    UIImageView* image = [[UIImageView alloc] init];
//    [self.view addSubview:image];
//
//    image.image = [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//
//    image.tintColor = [UIColor redColor];
//
//    self.view.tintColor = [UIColor yellowColor];
//
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:button];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [button setTitle:@"Click" forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"php_unfollow"] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"non_follow_bit"] forState:UIControlStateSelected];
//
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.center.equalTo(self.view);
//    }];
//
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* title = [[UILabel alloc] init];
    
    title.textColor = [UIColor blueColor];
    
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:@"哈哈哈我是红色字，哈哈哈哈"];
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromHEX(0xFF0000) range:NSMakeRange(3, 5)];
    title.attributedText = att;
    
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    
    UILabel* label = [[UILabel alloc] init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
    }];
    
    label.numberOfLines = 0;
    label.text = @"威马汽车与格力电器签署战略合作协议，双方将在智能制造、车家智能互联等智能化相关领域，"
    "以及整车制造相关、高端设备输出等方面展开深入合作，并将共同探索在渠道方面合作的可能性。";
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    QMUIAlertAction *action1 = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:NULL];
//    QMUIAlertAction *action2 = [QMUIAlertAction actionWithTitle:@"删除" style:QMUIAlertActionStyleDestructive handler:NULL];
//    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"确定删除？" message:@"删除后将无法恢复，请慎重考虑" preferredStyle:QMUIAlertControllerStyleAlert];
//    [alertController addAction:action1];
//    [alertController addAction:action2];
//    [alertController showWithAnimated:YES];
}

- (void)buttonClicked:(UIButton*)button {
    button.selected = !button.isSelected;
}

/**
 当strong，copy 赋值不是可变类型，结果是一致的。反之，strong是指针引用，copy是新申请内存。
 */
- (void)testCopy
{
    // first step
    NSString* testString = @"";
    
    NSString* targetString = @"123";
    
    testString = [targetString mutableCopy]; // copy 是指针复制，mutableCopy是内容复制，深拷贝
    
    targetString = @"456";
    
    // second step
    
    NSArray* testArray = @[];
    
    NSMutableArray* targetArray = [NSMutableArray array];
    
    [targetArray addObject:@"123"];
    
    testArray = [targetArray copy];
    
    [targetArray addObject:@"456"];
    
    
//    NSMutableString* abc = [[NSMutableString alloc] init];
    
    NSString* abc = @"123string";
    
    self.strongString = abc;
    self.copydString = abc;
    
//    [abc appendString:@"asdf"];
    
    abc = @"defkakakaka";
    
    
    NSArray* s = @[@""];
//    NSMutableArray* s1 = [s copy];
    NSMutableArray* s2 = [s mutableCopy];
    
//    [s addObject:@"4"]; // copy 后的不是mutable类型
    [s2 addObject:@"sdf"];
    
    
    self.strongArray = s2;
    self.copydArray = s2;
    
    [s2 addObject:@"def"];
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

/**
 Semaphore: 控制同时访问临界区的个数
 */
- (void)testSemaphore
{
    self.sem = dispatch_semaphore_create(1);
    
    for (int i = 0; i < 50; i ++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
            
            NSLog(@"item-%00004d", i);
            
            dispatch_semaphore_signal(self.sem);
        });
    }
}


/**
  打印数字内的所有质数

 @param n 测试数字
 */
- (void)testPrime:(NSInteger)n
{
    NSInteger i = 2;
    while (i < n) {
        
        NSInteger j = 2;
        while (j < i) {
            if (i%j == 0) {
                break;
            }
            j ++;
        }
        
        if (j == i) {
            NSLog(@"质数是:%ld", i);
        }
        
        i ++;
    }
}

/**
 测试队列调用
 */
- (void)testQueueCall
{
    self.testQueue = dispatch_queue_create("com.qq.asdf", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 50; i ++) {
        dispatch_async(self.testQueue, ^{
            
            NSLog(@"item1:%d", (int)i);
        });
    }
    
    
    for (int i = 0; i < 50; i ++) {
        dispatch_async(self.testQueue, ^{
            
            NSLog(@"item2:%d", (int)i);
        });
    }
}

@end
