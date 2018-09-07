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

@end

@implementation YMCommonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)dealloc
{
    NSLog(@"%@ %@...",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


/**
 测试循环引用：self强引用了block，block 引用了self的属性
 */
- (void)testBlockCyclicReference
{
    TestBlock aa = ^(int n) {
        NSLog(@"n:%d", n);
        self.name = @"asdfasdf";
    };
    
    self.name = @"";
    
    aa(10);
    
    self.bb = aa;
}

@end
