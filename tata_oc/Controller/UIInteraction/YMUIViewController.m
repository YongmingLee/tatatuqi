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
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.dataSources = @[@{@"cls":@"YMScrollViewController",@"desc":@"UIScrollView多滑动测试"},
                         @{@"cls":@"YMSafeAreaViewController",@"desc":@"布局测试"},
                         @{@"cls":@"YMAnimationViewController",@"desc":@"动画测试"},
                         @{@"cls":@"YMFeedsFlowViewController",@"desc":@"Feed文字流"},
                         @{@"cls":@"YMAutoFeedViewController",@"desc":@"Feed布局"}];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    
    Class vcCLS = NSClassFromString(data[@"cls"]);
    
    UIViewController* vc = [[vcCLS alloc] init];
    vc.title = data[@"desc"];
//    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
