//
//  ViewController.m
//  tata_oc
//
//  Created by yongming on 2018/6/14.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataSources;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"YM-Demo";
    // Do any additional setup after loading the view, typically from a nib.
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    tableView.tableFooterView = [UIView new];
    
    self.dataSources = @[@{@"cls":@"YMAlgorithmViewController",@"desc":@"算法测试"},
                         @{@"cls":@"YMScrollViewController",@"desc":@"UIScrollView多滑动测试"},
                         @{@"cls":@"YMChatViewController",@"desc":@"QQ闲聊SDK"},
                         @{@"cls":@"YMCommonViewController",@"desc":@"其它测试"}];
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
    }
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    
    cell.textLabel.text = data[@"desc"];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"class:%@", data[@"cls"]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    
    Class vcCLS = NSClassFromString(data[@"cls"]);

    UIViewController* vc = [[vcCLS alloc] init];
    vc.title = data[@"desc"];
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
