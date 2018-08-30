//
//  YMBinaryTreeViewController.m
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMBinaryTreeViewController.h"
#import "YMAlgorithmDrawView.h"

@interface YMBinaryTreeViewController ()
@property (nonatomic, strong) YMAlgorithmDrawView* drawView;
@end

@implementation YMBinaryTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.drawView = [[YMAlgorithmDrawView alloc] init];
    self.drawView.algoType = YMAlgoBinaryTree;
    [self.view addSubview:self.drawView];
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
