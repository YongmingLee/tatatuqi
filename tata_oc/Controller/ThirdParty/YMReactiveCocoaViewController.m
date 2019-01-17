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

@end

@implementation YMReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testObserve];
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
    
    // 组合信号测试
    self.signalB = [RACSubject subject];
    self.signalC = [RACSubject subject];
    
    RACSignal* signals = [self.signalB concat:self.signalC];
    [signals subscribeNext:^(id  _Nullable x) {
        NSLog(@"signals:%@", x);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
    
    [self.signalC sendNext:@30];
    [self.signalB sendNext:@20];
//    [self.signalB sendCompleted];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc...", NSStringFromClass([self class]));
}

@end
