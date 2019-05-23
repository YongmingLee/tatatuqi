//
//  YMThreadTestController.m
//  tata_oc
//
//  Created by yongming on 2019/3/11.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMThreadTestController.h"

@interface YMThreadTestController ()
@property (nonatomic, strong) dispatch_semaphore_t testSemaphore;
@end

@implementation YMThreadTestController

- (void) dealloc
{
    NSLog(@"thread controller is dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testGroupMore];
}

- (void)testGroup
{
    NSLog(@"start");
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1 - %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{ /*加载图片2 */
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2 - %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{ /*加载图片3 */
        [NSThread sleepForTimeInterval:3];
        NSLog(@"3 - %@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 合并图片
        
        NSLog(@"over");
    });
}

- (void)testRunloop
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        NSLog(@"This is a thread:%@", [NSThread currentThread]);
        
        NSRunLoop* currentRunloop = [NSRunLoop currentRunLoop];
        NSLog(@"Current runloop is :%@", currentRunloop);
        
        [currentRunloop runMode:UITrackingRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"runloop is over");
    });
    
    NSLog(@"The function live is over:%@", [NSThread currentThread]);
}

// 主要是针对信号量控制同步执行的一种方式
// Semaphore
- (void)testMultiRequest
{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSLog(@"start");

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"before sleep 3...");
        
        sleep(3);
        
        NSLog(@"after sleep");
        
        dispatch_semaphore_signal(sem);
    });

    NSLog(@"I am waiting the signal");

    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

    NSLog(@"Oh, over!!!");
}

// GCD Group 的应用
- (void)testGroupMore
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 100; i ++) {
        
        
        dispatch_group_async(group, queue, ^{
            
            NSLog(@"run : %d", i+1);
            
            sleep(1);
        });
    }
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"over!!!");
    });
}

@end
