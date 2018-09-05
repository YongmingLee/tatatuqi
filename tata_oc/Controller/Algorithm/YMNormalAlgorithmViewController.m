//
//  YMNormalAlgorithmViewController.m
//  tata_oc
//
//  Created by yongming on 2018/9/5.
//  Copyright © 2018年 yongming. All rights reserved.
//

#import "YMNormalAlgorithmViewController.h"

@interface YMNormalAlgorithmViewController ()

@end

@implementation YMNormalAlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    YMAlgorithm* algo = [[YMAlgorithm alloc] init];
    
    NSString* result = [algo reverseString:@"Hello World"];
    NSLog(@"result:%@", result);
}

@end
