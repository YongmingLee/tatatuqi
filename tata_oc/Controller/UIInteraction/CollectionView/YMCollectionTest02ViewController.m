//
//  YMCollectionTest02ViewController.m
//  tata_oc
//
//  Created by Yongming on 2019/9/10.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMCollectionTest02ViewController.h"
#import "YMProxy.h"

@interface JLNormalCollectionViewCell : UICollectionViewCell

@end

@implementation JLNormalCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor randomColor];
        self.layer.cornerRadius = 20;
    }
    
    return self;
}

@end

@interface YMCollectionTest02ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSTimer* testTimer;
@end

@implementation YMCollectionTest02ViewController

- (void)dealloc {
    NSLog(@"c02 dealloc...");
    if (self.testTimer) {
        [self.testTimer invalidate];
        self.testTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHEX(0xF3F2F6);
    
    const CGFloat itemWidth = (kScreenWidth - 15) * 0.5;
    const CGFloat itemGap = 5;
    UIEdgeInsets edge = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        edge = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
    }
    
    self.collectionView = [DGUIKitHelper collectionViewWithScrollDirection:UICollectionViewScrollDirectionVertical lineSpacing:itemGap interSpacing:itemGap itemSize:CGSizeMake(itemWidth, itemWidth) parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(edge.top + self.navigationController.navigationBar.frame.size.height + 5);
        make.bottom.mas_equalTo(-edge.bottom-5);
    }];
    
    self.collectionView.backgroundColor = UIColorFromHEX(0xF3F2F6);
    [self.collectionView registerClass:[JLNormalCollectionViewCell class] forCellWithReuseIdentifier:@"YMNormalCollectionViewCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:.1 target:[YMProxy proxyWithTarget:self] selector:@selector(testTimerHandler:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.testTimer = timer;
}

- (void)testTimerHandler:(NSTimer*)timer {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JLNormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YMNormalCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
