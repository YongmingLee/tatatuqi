//
//  YMSoundViewController.m
//  tata_oc
//
//  Created by Yongming on 2019/9/30.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMSoundViewController.h"
#import "YMSoundUtil.h"

@interface YMSoundViewController ()

@property (nonatomic, strong) YMSoundUtil* soundUtil;

@end

@implementation YMSoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton* startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startButton setTitle:@"开始监听" forState:UIControlStateNormal];
    [self.view addSubview:startButton];
    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    [startButton addTarget:self action:@selector(startButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopButton setTitle:@"停止监听" forState:UIControlStateNormal];
    [self.view addSubview:stopButton];
    [stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(startButton.mas_bottom).offset(20);
        make.height.mas_equalTo(30);
    }];
    [stopButton addTarget:self action:@selector(stopButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    startButton.backgroundColor = [UIColor redColor];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    stopButton.backgroundColor = [UIColor redColor];
    [stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)startButtonDidClicked {
     
    if (!self.soundUtil) {
        self.soundUtil = [[YMSoundUtil alloc] init];
    }
    
    [self.soundUtil startCapturingOnView:self.view];
}

- (void)stopButtonDidClicked {
    
    [self.soundUtil stopCapturing];
}

@end
