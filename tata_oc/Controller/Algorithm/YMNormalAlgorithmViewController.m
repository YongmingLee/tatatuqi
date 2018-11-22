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
    
    NSString* testString = @"asdflasdfj239447825lkgksdf7ga34234ldfkgjldjfg843984573rssfdlsdfjl今天中午12点半，辽宁省葫芦岛市建昌县第二小学校门前，发生重大交通事故，已致5人死亡，18人受伤。目前，相关部门已成立事故处置组、医疗救助组等工作组，肇事嫌疑人已被抓获，事故原因正在调查中。";
    
    NSLog(@"source string:%@", testString);
    
    NSString* result = [algo reverseString:testString];
    NSLog(@"reverse string:%@", result);
    
    result = [algo bubbleSort:testString];
    NSLog(@"bubble string:%@", result);
    
    result = [algo quickSort:testString];
    NSLog(@"quick string:%@", result);
}



@end
