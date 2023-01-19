//
//  YMNormalAlgorithmViewController.m
//  tata_oc
//
//  Created by yongming on 2018/9/5.
//  Copyright © 2018年 yongming. All rights reserved.
//

#import "YMNormalAlgorithmViewController.h"
#ifdef _Use_Ymutil_
#import <YMVersionUtil.h>
#endif

@interface LGPerson : NSObject
@property (nonatomic, retain) NSString *kc_name;
- (void)saySomething;
@end

@implementation LGPerson

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"__init...");
        self.kc_name = @"Hello";
    }
    return self;
}

- (void)saySomething{
    NSLog(@"%s - %@",__func__,self.kc_name);
}
@end

@interface LGTeacher : LGPerson

@end

@implementation LGTeacher
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@ - %@",[self class],[super class]);
    }
    return self;
}
@end

@interface YMNormalAlgorithmViewController ()
@property (nonatomic, assign) long num;
@property (nonatomic, strong) NSLock* numLock;
@property (nonatomic, strong) NSTimer* timer;
@end

static YMNormalAlgorithmViewController* weakself = nil;

@implementation YMNormalAlgorithmViewController

- (void)dealloc {
    NSLog(@"YMNormalAlgorithmViewController dealloc...");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
#ifdef _Use_Ymutil_
    NSString* version = [YMVersionUtil birthday];
    NSLog(@"The birthday is %@", version);
#endif
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    weakself = self;
    
    [self test];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // timer可以构成强引用
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    // 静态堆变量持有主体，也会导致强引用导致内存不能被释放
    weakself = nil;
}

- (void)test {
    
    NSObject * objc = [NSObject alloc];
    NSLog(@"%ld 1---- %@ ---- %p",CFGetRetainCount((__bridge CFTypeRef)objc), objc, &objc);
    NSObject * new_objc = objc;
    NSLog(@"%ld 2---- %@ ---- %p",CFGetRetainCount((__bridge CFTypeRef)objc), objc, &objc);
    NSLog(@"%ld ---- %@ ---- %p",CFGetRetainCount((__bridge CFTypeRef)new_objc), new_objc, &new_objc);
    
    
    
    
    //    self.numLock = [[NSLock alloc] init];
    //    [self MTDemo];
    //    [self KSDemo];
    
    // test case
    //    Class cls = [LGPerson class];
    //    void  *kc = &cls;
    //    [(__bridge id)kc saySomething];
    
    //    LGTeacher *t = [[LGTeacher alloc] init];
}

- (void)test2 {
    YMAlgorithm* algo = [[YMAlgorithm alloc] init];
    
    NSString* testString = @"asdflasdfj239447825lkgksdf7ga34234ldfkgjldjfg843984573rssfdlsdfjl今天中午12点半，辽宁省葫芦岛市建昌县第二小学校门前，发生重大交通事故，已致5人死亡，18人受伤。目前，相关部门已成立事故处置组、医疗救助组等工作组，肇事嫌疑人已被抓获，事故原因正在调查中。";
    
    NSLog(@"source string:%@", testString);
    
    NSString* result = [algo reverseString:testString];
    NSLog(@"reverse string:%@", result);
    
    result = [algo bubbleSort:testString];
    NSLog(@"bubble string:%@", result);
    
    result = [algo quickSort:testString];
    NSLog(@"quick string:%@", result);
}

#pragma mark - 普通测试
- (void)MTDemo{
    while (self.num < 5) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.num++;
        });
    }
    NSLog(@"KC : %ld",self.num);
}

- (void)KSDemo{
    for (int i= 0; i<10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            [self.numLock lock];
            self.num++;
//            [self.numLock unlock];
        });
    }
    NSLog(@"Cooci : %ld",self.num);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Cooci2 : %ld",self.num);
    });
}

- (void)test3 {
    [self textDemo2];
    [self textDemo1];
}

- (void)textDemo2{
    dispatch_queue_t queue = dispatch_queue_create("cooci", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)textDemo1{
    
    dispatch_queue_t queue = dispatch_queue_create("cooci", NULL);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)timerHandler {
    NSLog(@"timer...");
}

@end
