//
//  YMUIViewController.m
//  tata_oc
//
//  Created by yongming on 2018/9/7.
//  Copyright © 2018年 yongming. All rights reserved.
//

#import "YMUIViewController.h"

@interface YMUIViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataSources;
@end

@implementation YMUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor greenColor];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.dataSources = @[@{@"cls":@"YMScrollViewController",@"desc":@"UIScrollView多滑动测试"},
                         @{@"cls":@"YMSafeAreaViewController",@"desc":@"布局测试"},
                         @{@"cls":@"YMAnimationViewController",@"desc":@"动画测试"},
                         @{@"cls":@"YMFeedsFlowViewController",@"desc":@"Feed文字流"},
                         @{@"cls":@"YMAutoFeedViewController",@"desc":@"Feed布局"},
                         @{@"cls":@"YMSysAutoFeedViewController",@"desc":@"Feed系统布局"},
                         @{@"cls":@"YMTestSwipCellViewController",@"desc":@"测试cell滑动"},
                         @{@"cls":@"YMUITableViewTestViewController",@"desc":@"UITableView测试"},
                         @{@"cls":@"YMCollectionTest01ViewController",@"desc":@"UICollectionView测试01"},
                         @{@"cls":@"YMCollectionTest02ViewController",@"desc":@"UICollectionView测试02"},
                         @{@"cls":@"YMNaviBarTestViewController",@"desc":@"NavBar测试"},
                         @{@"cls":@"YMRoundCellTestViewController",@"desc":@"圆形Cell测试"},
                         @{@"cls":@"YMRotationViewController",@"desc":@"旋转测试"},
                         @{@"cls":@"YMTestLayoutViewController",@"desc":@"Layout测试"},
                         @{@"cls":@"YMWebViewController",@"desc":@"webview"}];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"testcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"testcell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"class:%@", data[@"cls"]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.text = data[@"desc"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    
    Class vcCLS = NSClassFromString(data[@"cls"]);
    
    UIViewController* vc = [[vcCLS alloc] init];
    vc.title = data[@"desc"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
