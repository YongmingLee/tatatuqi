//
//  YMCommonViewController.m
//  tata_oc
//
//  Created by yongming on 2018/8/29.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMCommonViewController.h"
#import "MSWeakTimer.h"
#import "YMFruit.h"
#import <SDWebImage/SDWebImage.h>
#include "YMLeetCode.h"

@interface MyButton : UIButton

@end

@implementation MyButton

- (void)addCustomEvent:(id)target sel:(SEL)sel {
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

- (void)doAnimation {
    self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
}

@end

typedef void (^TestBlock)(int);

@interface JLPCTextSubModel : NSObject
@property (nonatomic, strong) NSString* fromtype;
@property (nonatomic, strong) NSString* fromlevel;
@property (nonatomic, strong) NSString* totype;
@property (nonatomic, strong) NSString* tolevel;
@property (nonatomic, strong) NSString* msgtype;
- (void)test;
@end
@implementation JLPCTextSubModel
- (void)test {
    self.fromtype = @"Call from inner";
}
@end

@interface JLPCTextMessageModel : NSObject
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* extra;
@end

@implementation JLPCTextMessageModel
@end

@interface MyView : UIView

@property (nonatomic, assign) BOOL flag;
@property (nonatomic, strong) UIButton* button;

- (void)testAni;

@end

@implementation MyView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.flag = YES;
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"点我" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDidClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        button.backgroundColor = [UIColor randomColor];
        self.button = button;
    }
    return self;
}

#ifndef _USE_PARENT_DETECT_TAP_
// 处理点击事件，通过事件判断坐标
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint locationPoint = [self.layer convertPoint:point toLayer:self.layer.presentationLayer];
    CALayer* layer = self.layer.presentationLayer;
    if (CGRectContainsPoint(self.button.bounds, locationPoint)) {
        NSLog(@"点中了:%@, location:%@", NSStringFromCGRect(layer.bounds), NSStringFromCGPoint(locationPoint));
        return self;
    }
    
    if (!layer) {
        NSLog(@"hit super");
        return [super hitTest:point withEvent:event];
    }
    
    NSLog(@"nop");
    
    return nil;
}

#endif

- (void)buttonDidClicked {
    NSLog(@"button did click...");
}

- (void)testAni {
    [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(self.flag ? -200 : 200, 0);
    } completion:^(BOOL finished) {
        self.flag = !self.flag;
        [self testAni];
    }];
}

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

@property (nonatomic, strong) MSWeakTimer* testTimer;
@property (nonatomic, strong) MASConstraint* testConstraint;
@property (nonatomic, strong) MASConstraint* testLeftConstraint;

@property (nonatomic, strong) NSMutableArray* fruits;

@property (nonatomic, strong) NSMutableString* testString;
@property (nonatomic, strong) NSString* param1;
@property (nonatomic, copy) NSString* param2;

@property (nonatomic, strong) JLPCTextSubModel* kvoTestModel;

@property (nonatomic, strong) UIButton* testAniButton;

@property (nonatomic, strong) MyView* myView;

@property (nonatomic, strong) UIView* backView;

@property (nonatomic, strong) UIView* testWindow;

@end

@implementation YMCommonViewController

- (void)dealloc {
    if (self.testTimer) {
        [self.testTimer invalidate];
    }
    
    GGLogDebug(@"%@ %@...",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)testAnimation {
    MyView* v = [[MyView alloc] initWithFrame:CGRectMake(150, 180, 100, 100)];
    [self.view addSubview:v];
    [v testAni];
    self.myView = v;
    
#ifdef _USE_PARENT_DETECT_TAP_
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tap];
#endif
    
    UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(150, 180, 200, 200)];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self.view insertSubview:backView atIndex:0];
    self.backView = backView;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(scaleButtonCLicke) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    BOOL flag = YES;
    
    [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (flag) {
                SDAnimatedImageView *giftImageView = [[SDAnimatedImageView alloc] init];
                [backView addSubview:giftImageView];
                [giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(backView);
                }];
                NSString* giftImageUrl = @"https://res.guagua.cn/pic//8226.gif";
                [giftImageView sd_setImageWithURL:[NSURL URLWithString:giftImageUrl] placeholderImage:nil options:SDWebImageRefreshCached|SDWebImageAllowInvalidSSLCertificates completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    GGLogDebug(@"The cache file:%@", [[SDImageCache sharedImageCache] cachePathForKey:giftImageUrl]);
                }];
                [giftImageView stopAnimating];
            }
        });
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTestWindowUI];
}

- (void)prtWindows {
    GGLogDebug(@"mywindow:%@", self.view.window);
    GGLogDebug(@"subwindow:%@", [UIApplication sharedApplication].windows);
}

- (UIWindow*)queryKeyWindow {
    return self.view.window;
}

- (void)addWindowFun {
    /*
    UIViewController* vc = [[UIViewController alloc] init];
    vc.title = @"demo";
    vc.view.backgroundColor = [UIColor redColor];
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView* testView = [[UIView alloc] init];
    testView.backgroundColor = [UIColor yellowColor];
    [vc.view addSubview:testView];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    nav.navigationBar.backgroundColor = [UIColor greenColor];
    [self presentViewController:nav animated:YES completion:nil];
    
    return;
    */
    
    self.testWindow = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 100)*.5, 100, 100, 100)];
    self.testWindow.backgroundColor = [UIColor yellowColor];
    self.testWindow.hidden = NO;
    UIWindow* keyWindow = [self queryKeyWindow];
    [keyWindow addSubview:self.testWindow];
     
    [self prtWindows];
}

- (void)removeWindowFun {
    if (self.testWindow) {
        [self.testWindow removeFromSuperview];
        self.testWindow = nil;
    }
    
    [self prtWindows];
}

- (void)addTestWindowUI {
    UIButton* addWindowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addWindowButton addTarget:self action:@selector(addWindowFun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addWindowButton];
    [addWindowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.view).offset(-70);
    }];
    
    UIButton* removeWindowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeWindowButton addTarget:self action:@selector(removeWindowFun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeWindowButton];
    [removeWindowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.view).offset(70);
    }];
    
    addWindowButton.backgroundColor = [UIColor greenColor];
    removeWindowButton.backgroundColor = [UIColor redColor];
}

- (void)testLeetCode {
    char s[] = "dvdf";//"pwwkew";
    int n = lengthOfLongestSubstring(s);
    NSLog(@"");
}

- (void)scaleButtonCLicke {
    [self testScale];
}

- (void)testScale {
    NSTimeInterval duration = 0.3;
    
    // dampingRatio（阻尼系数）
    // 范围 0~1 当它设置为1时，动画是平滑的没有振动的达到静止状态，越接近0 振动越大
    CGFloat fDamping = 1;
    
    // velocity （弹性速率）
    // 就是形变的速度，从视觉上看可以理解弹簧的形变速度，到动画结束，该速度减为0，所以，velocity速度越大，那么形变会越快，当然在同等时间内，速度的变化（就是速率）也会越快，因为速度最后都要到0。
    CGFloat fVelocity = -20;
#ifdef __USE_DAMPING__
    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
        transform = CGAffineTransformTranslate(transform, 6, 0);
        self.backView.transform = transform;
    } completion:^(BOOL finished) {
        self.backView.transform = CGAffineTransformIdentity;
    }];
#else
    [UIView animateWithDuration:duration delay:0. usingSpringWithDamping:fDamping initialSpringVelocity:fVelocity options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(2, 2);
        transform = CGAffineTransformTranslate(transform, 6, 0);
        self.backView.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:1 initialSpringVelocity:20 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.backView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
#endif
    
}

- (void)handleTapGesture:(UITapGestureRecognizer*)tap {
    CGPoint touchPoint = [tap locationInView:self.view];
    for (UIView *marqueeView in self.view.subviews) {
        
        if (marqueeView == self.myView) {
            
            MyView* myView = (MyView*)(marqueeView);
            
            CALayer *layer = [myView.button.layer.presentationLayer hitTest:touchPoint];
            if (layer) {
                
                CGPoint localPt = [tap locationInView:marqueeView];
                
                GGLogDebug(@"tap at:%@ - %@", NSStringFromCGPoint(localPt), NSStringFromCGPoint(touchPoint));
                break;
            }
        }
    }
}


#pragma mark -

- (void)startAnimation {
    
    [self.testAniButton layoutIfNeeded];
    
    CGFloat width = self.view.bounds.size.width;
//    CABasicAnimation *basicAni1 = [[CABasicAnimation alloc] init];
//    basicAni1.keyPath = @"position.x";
//    basicAni1.fromValue = [NSNumber numberWithFloat:kScreenWidth + width * 0.5];
    
    CGFloat toValue = width;
    if (width < kScreenWidth) {
        toValue = kScreenWidth * 0.5;
    } else {
        toValue = kScreenWidth - width * 0.5;
    }
    
    CGFloat animateTime = 6.0;
    CGFloat delayTime = 3.0;
//    basicAni1.toValue = [NSNumber numberWithFloat:toValue];
//    basicAni1.duration = animateTime;
//    basicAni1.fillMode = kCAFillModeForwards;
//    basicAni1.beginTime = 0;
//    basicAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
    __block CGRect frame = self.testAniButton.frame;
    frame.origin.x = kScreenWidth + width * .5;
    self.testAniButton.frame = frame;
    [UIView animateWithDuration:6 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        frame.origin.x = 0;
        self.testAniButton.frame = frame;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:6 delay:delayTime options:UIViewAnimationOptionAllowUserInteraction animations:^{
            frame.origin.x = -width;
            self.testAniButton.frame = frame;
        } completion:^(BOOL finished) {
            
            
        }];
    }];
    
    
//    CABasicAnimation *basicAni2 = [[CABasicAnimation alloc] init];
//    basicAni2.keyPath = @"position.x";
//    basicAni2.toValue = [NSNumber numberWithFloat:-width];
//    basicAni2.duration = animateTime;
//    basicAni2.beginTime = animateTime + delayTime;
//    basicAni2.fillMode = kCAFillModeForwards;
//    basicAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    CAAnimationGroup *groupAni = [[CAAnimationGroup alloc] init];
//    [groupAni setRemovedOnCompletion:NO];
//    groupAni.duration = animateTime * 2 + delayTime;
//    groupAni.delegate = self;
//    groupAni.animations = @[basicAni1, basicAni2];
//    [self.layer addAnimation:groupAni forKey:nil];
//
//    self.userInteractionEnabled = YES;
}

- (void)testKVO {
    NSLog(@"begin kvo start...");
    self.kvoTestModel = [[JLPCTextSubModel alloc] init];
    [self.kvoTestModel addObserver:self forKeyPath:@"fromtype" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.kvoTestModel.fromtype = @"1";
    [self.kvoTestModel setValue:@"ok" forKey:@"fromtype"];
    [self.kvoTestModel test];
    [self.kvoTestModel addObserver:self forKeyPath:@"totype" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.kvoTestModel.totype = @"totest";
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath:%@,object:%@,change:%@,context:%@", keyPath, object, change, context);
}

- (void)testButton {
    MyButton* button = [MyButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"title" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    if (@available(iOS 11, *)) {
        [button setBackgroundColor:[UIColor colorNamed:@"test_cr"]];
    } else {
        [button setBackgroundColor:[UIColor whiteColor]];
    }
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.center.equalTo(self.view);
    }];
    
    [button addCustomEvent:self sel:@selector(testButtonClicked:)];
}

- (void)testButtonClicked:(MyButton*)button {
    NSLog(@"test button clicked");
    [button doAnimation];
}

- (void)testImage {
    
    CGSize size = CGSizeMake(200, 100);
    UIImage* img = [UIImage imageWithColor:[UIColor redColor] size:size cornerRadius:30];
    
    UIImageView* imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    imageView.image = img;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(size);
    }];
    
    imageView.backgroundColor = [UIColor yellowColor];
}

- (void)testLabelLayout {
    UIView* v = [[UIView alloc] init];
    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UILabel* label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    [v addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.equalTo(v.mas_right);
    }];
    label.text = @"UIWindow类";
    label.backgroundColor = [UIColor blackColor];
    label.preferredMaxLayoutWidth = 200;
    label.numberOfLines = 0;
}

/// 测试谓词
- (void)testPredication {
    self.fruits = [NSMutableArray array];

    YMFruit* fruit = [[YMFruit alloc] init];
    fruit.name = @"apple";
    fruit.price = 5.3;
    [self.fruits addObject:fruit];
    
    fruit = [[YMFruit alloc] init];
    fruit.name = @"orange";
    fruit.price = 6.8;
    [self.fruits addObject:fruit];
    
    fruit = [[YMFruit alloc] init];
    fruit.name = @"watermelon";
    fruit.price = 1.3;
    [self.fruits addObject:fruit];
    
    fruit = [[YMFruit alloc] init];
    fruit.name = @"lemon";
    fruit.price = 9.9;
    [self.fruits addObject:fruit];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price<%d", 6];
    NSArray* lessThan5 = [self.fruits filteredArrayUsingPredicate:predicate];
    for (YMFruit* item in lessThan5) {
        GGLogDebug(@"The fruit less than 5 is:%@, it's price is:%.2f", item.name, item.price);
    }
    
    predicate = [NSPredicate predicateWithFormat:@"name CONTAINS 'm'"];
    NSArray* names = [self.fruits filteredArrayUsingPredicate:predicate];
    for (YMFruit* item in names) {
        GGLogDebug(@"The fruit name contain 'm' is:%@, it's price is:%.2f", item.name, item.price);
    }
}

- (void)buttonClicked:(UIButton*)button {
    button.selected = !button.isSelected;
}

- (NSArray*)testCallArray {
    NSArray* arr = @[@"a", @"b"];
    return [arr mutableCopy];
}

/**
 当strong，copy 赋值不是可变类型，结果是一致的。反之，strong是指针引用，copy是新申请内存。
 */
- (void)testCopy
{
    NSArray* ret = [self testCallArray];
    
    // MARK: NSString test
    self.testString = [NSMutableString stringWithString:@"hello"]; // 此处如果是NSString，那么strong和copy没有区别
    self.param1 = self.testString;
    self.param2 = self.testString;
    
    [self.testString appendString:@"world"];
    
    
    // MARK: Array test
    NSArray* s = @[@"nn"];
    NSMutableArray* s2 = [s mutableCopy]; // 此处copy的话，copy出来的是NSArray，不能添加
    [s2 addObject:@"sdf"];
    
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

- (void)testCenterHorizon {
    UIView* containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    containerView.backgroundColor = [UIColor redColor];
    
    UILabel* label = [[UILabel alloc] init];
    [containerView addSubview:label];
    label.text = @"asdlfjlajsdlfj123";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    label.backgroundColor = [UIColor yellowColor];
    
    UIView* smallBlockView = [[UIView alloc] init];
    smallBlockView.backgroundColor = [UIColor blueColor];
    [containerView addSubview:smallBlockView];
    [smallBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        self.testConstraint = make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        self.testLeftConstraint = make.left.equalTo(label.mas_right);
    }];
    
    self.testTimer = [MSWeakTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(handleTestTimer) userInfo:nil repeats:YES dispatchQueue:dispatch_get_main_queue()];
}

- (void)handleTestTimer {
    if (!self.testConstraint) {
        NSLog(@"The constraint not ready");
        return;
    }
    
    static int i = 0;
    i ++;
    
    int n = i % 4;
    NSLog(@"testV:%d", n);
    
    // Clockwise
    
    [UIView animateWithDuration:.3 animations:^{
        
        switch (n) {
            case 0: // 12点钟方向
            {
                self.testLeftConstraint.offset(10);
                self.testConstraint.mas_equalTo(-5);
            }
                break;
            case 1:
            {
                self.testLeftConstraint.offset(15);
                self.testConstraint.mas_equalTo(0);
            }
                break;
            case 2:
            {
                self.testLeftConstraint.offset(10);
                self.testConstraint.mas_equalTo(5);
            }
                break;
            case 3:
            {
                self.testLeftConstraint.offset(5);
                self.testConstraint.mas_equalTo(0);
            }
                break;
                
            default:
                break;
        }
        
        [self.view layoutIfNeeded];
    }];
}

@end
