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
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat w = kScreenWidth * .5 - 4;
    layout.itemSize = CGSizeMake(w, w);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    UICollectionView* _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[JLNormalCollectionViewCell class] forCellWithReuseIdentifier:@"YMNormalCollectionViewCell"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor yellowColor];
    
    self.collectionView = _collectionView;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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
