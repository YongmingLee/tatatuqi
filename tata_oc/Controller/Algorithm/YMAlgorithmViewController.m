//
//  YMAlgorithmViewController.m
//  tata_oc
//
//  Created by yongming on 2018/8/30.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAlgorithmViewController.h"

@interface YMAlgorithmViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataSources;
@end

@implementation YMAlgorithmViewController

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
    
    self.dataSources = @[@{@"cls":@"YMBinaryTreeViewController",@"desc":@"生成二叉树"},
                         @{@"cls":@"YMRBTreeViewController",@"desc":@"红黑树"},
                         @{@"cls":@"YMNormalAlgorithmViewController",@"desc":@"普通算法"}];
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
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
