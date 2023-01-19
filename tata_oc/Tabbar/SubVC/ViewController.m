//
//  ViewController.m
//  tata_oc
//
//  Created by yongming on 2018/6/14.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "tata_oc-Swift.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataSources;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateUI];
}

#pragma mark - private
- (void)updateUI {
    self.title = @"「求知若饥，虚心若愚」";
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    tableView.tableFooterView = [UIView new];
    
    self.dataSources = @[@{@"cls":@"YMAlgorithmViewController", @"desc":@"算法"},
                         @{@"cls":@"YMMathsViewController", @"desc":@"数学"},
                         @{@"cls":@"YMPhysicsViewController", @"desc":@"物理"},
                         @{@"cls":@"YMUIViewController", @"desc":@"用户交互"},
                         @{@"cls":@"YMThreadTestController", @"desc":@"线程测试"},
                         @{@"cls":@"YMThirdPartyViewController", @"desc":@"第三方"},
                         @{@"cls":@"YMCommonViewController", @"desc":@"基础"},
                         @{@"cls":@"YMSoundViewController", @"desc":@"音频"},
                         @{@"cls":@"TonglinVC", @"desc":@"Swift"}];
}

#pragma mark - UITableView delegate
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
    
    cell.textLabel.text = data[@"desc"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"class:%@", data[@"cls"]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* data = [self.dataSources objectAtIndex:indexPath.row];
    NSString* classString = data[@"cls"];
    
    if ([classString isEqualToString:@"TonglinVC"]) {
        TonglinVC* vc = [[TonglinVC alloc] init];
        vc.title = data[@"desc"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        Class vcCLS = NSClassFromString(classString);
        
        UIViewController* vc = [[vcCLS alloc] init];
        vc.title = data[@"desc"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
