//
//  YMNaviBarTestViewController.m
//  tata_oc
//
//  Created by Yongming on 2019/8/2.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMNaviBarTestViewController.h"

@interface YMNaviBarTestViewController ()

@end

@implementation YMNaviBarTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_nav_sug_bk"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

@end
