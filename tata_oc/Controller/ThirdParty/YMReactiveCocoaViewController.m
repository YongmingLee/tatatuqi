//
//  YMReactiveCocoaViewController.m
//  tata_oc
//
//  Created by yongming on 2019/1/17.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMReactiveCocoaViewController.h"

/*
 ReactiveCocoa 测试代码
 
 */

@interface YMReactiveCocoaViewController ()
@property (nonatomic, strong) NSString* stringValueTest;

@property (nonatomic, strong) RACSubject* signalA;

@property (nonatomic, strong) RACSubject* signalB;
@property (nonatomic, strong) RACSubject* signalC;

@property (nonatomic, strong) RACSubject* signalD;
@property (nonatomic, strong) RACSubject* signalE;

@property (nonatomic, strong) RACDisposable* intervalDisposable;

@end

@implementation YMReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testObserve];
    [self test1];
}

- (void)test1
{
    // take 只取前几次的信号
    // throttle 节流
    self.signalB = [RACSubject subject];
    self.signalC = [RACSubject subject];
    RACSignal* concatSignal = [self.signalB concat:self.signalC];
    [[[concatSignal take:2000] throttle:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"concat:%@", x);
    }];
    
    // 定时
//    self.intervalDisposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
//        NSLog(@"interval:%@", x);
//    }];
}

- (void)triggerTest1
{
    [self.signalB sendNext:@1];
    
    [self.signalC sendNext:@100];
}

- (void)testObserve
{
    // 代替KVO，监控属性的变化，不需要管析构的事情
    [RACObserve(self, stringValueTest) subscribeNext:^(id  _Nullable x) {
        NSLog(@"observer test:%@", x);
    }];
    
    // 创建一个信号，在其他地方激活。订阅后的线程等于触发信号所在的线程。
    self.signalA = [RACSubject subject];
    [self.signalA subscribeNext:^(id  _Nullable x) {
        NSLog(@"signal[Thread:%d]:%@", [NSThread isMainThread], x);
    }];
    
    
    /*
     * combineLatest: 并的关系
     * merge: 或的关系
     */
    
    // 组合信号测试 (∪)
    self.signalB = [RACSubject subject];
    self.signalC = [RACSubject subject];
    [[RACSignal combineLatest:@[self.signalB, self.signalC]] subscribeNext:^(RACTuple * _Nullable x) {
        // 只有两个信号都触发后，才能收到回调
        NSLog(@"combine ...");
    }];
    
    // 只要有一个信号触发，就回调。（|）
    self.signalD = [RACSubject subject];
    self.signalE = [RACSubject subject];
    [[RACSignal merge:@[self.signalD, self.signalE]] subscribeNext:^(id  _Nullable x) {
       
        NSLog(@"merge...");
    }];
}

- (void)triggerObserve
{
    // 更改观察者属性
    static bool state = true;
    self.stringValueTest = [NSString stringWithFormat:@"%d", state];
    state = !state;
    
    // 可以发任何信号，必须是对象
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 1; i ++) {
            [self.signalA sendNext:@100];
            [self.signalA sendNext:@{@"name":@"dog", @"age":[NSNumber numberWithInt:i]}];
        }
    });
    
    // 触发两个信号，触发组合信号
    [self.signalB sendNext:@20];
    [self.signalC sendNext:@30];
    
    // merge 测试
    [self.signalE sendNext:@1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self triggerTest1];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc...", NSStringFromClass([self class]));
    
    if (self.intervalDisposable) {
        [self.intervalDisposable dispose];
    }
}

@end
