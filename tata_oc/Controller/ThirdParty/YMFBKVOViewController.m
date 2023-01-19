//
//  YMFBKVOViewController.m
//  tata_oc
//
//  Created by yongming on 2021/3/15.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "YMFBKVOViewController.h"

@interface FBTestModel : NSObject
@property (nonatomic, strong) NSString* name;
@end

@implementation FBTestModel

@end

@interface FBTestSubController : YMBaseViewController
@property (nonatomic, strong) id model;
@end

@implementation FBTestSubController

- (instancetype)initWithParentVC:(id)model {
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DGUIKitHelper buttonWithFont:[UIFont systemFontOfSize:20] titleColor:[UIColor orangeColor] backgroundColor:[UIColor grayColor] cornerRadius:10 title:@"测试修改" parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-40);
        make.height.mas_equalTo(50);
    } target:self touchAction:@selector(subVCClicked)];
}

- (void)subVCClicked {
    [self.model setValue:@"1" forKey:@"name"];
}

@end



@interface YMFBKVOViewController ()
@property (nonatomic, strong) FBTestModel* model;
@end

@implementation YMFBKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [[FBTestModel alloc] init];
    
    [DGUIKitHelper buttonWithFont:[UIFont systemFontOfSize:20] titleColor:[UIColor orangeColor] backgroundColor:[UIColor grayColor] cornerRadius:10 title:@"测试" parentView:self.view constraintBlock:^(MASConstraintMaker * _Nonnull make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-40);
        make.height.mas_equalTo(50);
    } target:self touchAction:@selector(subVCClicked)];
    
    // create KVO controller with observer
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;

    // observe clock date property
    [self.KVOController observe:self.model keyPath:@"name" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id observer, FBTestModel* object, NSDictionary *change) {
        
        NSString* newValue = change[NSKeyValueChangeNewKey];
        NSLog(@"The changed value:%@, observer:%@, object:%@, objname:%@", newValue, observer, object, object.name);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"The name is:%@", self.model.name);
}

- (void)subVCClicked {
    FBTestSubController* vc = [[FBTestSubController alloc] initWithParentVC:self.model];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc
{
    NSLog(@"YMFBKVOViewController dealloc...");
}

@end
