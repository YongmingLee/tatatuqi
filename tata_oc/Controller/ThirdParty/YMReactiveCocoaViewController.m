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

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation YMReactiveCocoaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test5];
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
    self.intervalDisposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"interval:%@", x);
    }];
    
    
    // 基本的信号使用：创建信号，订阅信号，启动信号
    
    RACSignal* signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        self.subscriber = subscriber;
        
        return [RACDisposable disposableWithBlock:^{
            
            NSLog(@"我结束了");
        }];
    }];
    
    RACDisposable* dispos = [signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"哇，事件发生了:%@", x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.subscriber sendNext:@(2)];

        [dispos dispose];
    });
}

// 创建信号，可以不用block，直接用RACSubject启动信号
- (void)test2
{
    RACSubject* subject = [RACSubject subject];
    
    [subject sendNext:@(100)]; // 响应不到，因为还没有订阅
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者:%@", x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者:%@", x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [subject sendNext:@(500)];
    });
}

// RACReplaySubject 可以先订阅，事件激发后，可以激活
- (void)test3
{
    RACReplaySubject* subject = [RACReplaySubject subject];
    
    [subject sendNext:@(100)]; // 可以响应，虽然还没有订阅，但是RACReplaySubject 支持后订阅收消息模式。
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者:%@", x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者:%@", x);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [subject sendNext:@(500)];
    });
}

// 数组的分类，用于遍历
- (void)test4
{
    NSArray* arr = @[@"a", @"b", @"c", @"123"];
    
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"x:%@", x);
    }];
    
    NSDictionary* dic = @{@"name":@"tom", @"age":@(23)};
    [dic.rac_sequence.signal subscribeNext:^(RACTuple* x) {
        
        // 解包元组
//        RACTupleUnpack(NSString* key, NSString* value) = x;
        
        NSLog(@"key:%@,value:%@", x[0], x[1]);
    }];
    
    // map 用法
    NSArray* arrNew = [[arr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        
        return [NSString stringWithFormat:@"item :%@", value];
    }] array];
    
    NSLog(@"arrNew:%@", arrNew);
}

- (void)test5
{
    RACCommand* command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSLog(@"command 创建了信号");
           
            return [RACDisposable disposableWithBlock:^{
               
                NSLog(@"command 内 信号 析构了");
            }];
        }];
    }];
    
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
       
        NSLog(@"command 信号收到了");
    }];
    
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue == YES) {
            NSLog(@"command 正在执行");
        } else {
            NSLog(@"command 执行结束");
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [command execute:@(101)];
    });
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
