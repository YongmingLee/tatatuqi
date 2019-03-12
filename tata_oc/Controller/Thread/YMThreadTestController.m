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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testMultiRequest];
}

- (void)testMultiRequest
{
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    
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

- (void)testGroup
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 100; i ++) {
        
        
        dispatch_group_async(group, queue, ^{
            
            NSLog(@"run : %d", i+1);
            
            sleep(3);
        });
    }
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"over!!!");
    });
}

@end
