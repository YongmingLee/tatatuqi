//
//  YMCollectionTest01ViewController.m
//  tata_oc
//
//  Created by Yongming on 2019/6/12.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMCollectionTest01ViewController.h"

@interface JLUserCollectionViewCell : UICollectionViewCell

@end

@implementation JLUserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        UIView* b = [[UIView alloc] init];
        b.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:b];
        
        [b mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.left.mas_equalTo(-3);
            make.top.mas_equalTo(-3);
        }];
        
        
        UIView* a = [[UIView alloc] init];
        a.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:a];
        
        [a mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.right.mas_equalTo(3);
            make.bottom.mas_equalTo(3);
        }];
    }
    
    return self;
}

@end

@interface YMCollectionTest01ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation YMCollectionTest01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(32, 32);
    layout.minimumLineSpacing = 4;
    
    UICollectionView* _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[JLUserCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - UICollectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JLUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
