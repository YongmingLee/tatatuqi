//
//  YMUITableViewTestViewController.m
//  tata_oc
//
//  Created by yongming on 2019/3/20.
//  Copyright © 2019 yongming. All rights reserved.
//

#import "YMUITableViewTestViewController.h"

@interface YMUITableViewTestViewController () <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat m_fHeaderHeight;
}

@property (nonatomic, strong) UIView* headerView;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation YMUITableViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    headerView.backgroundColor = [UIColor redColor];
    self.headerView = headerView;
    
    m_fHeaderHeight = 120;
    
    UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:table];
    table.dataSource = self;
    table.delegate = self;
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView = table;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = /*IS_AlliPhoneX ? UIScrollViewContentInsetAdjustmentAutomatic :*/ UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerHandler
{
    NSArray* heights = @[@50,@120,@33,@99,@200,@10,@60,@160];
    
    int i = (arc4random() % heights.count);
    
    m_fHeaderHeight = ((NSNumber*)heights[i]).floatValue;
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGRect frame = self.headerView.frame;
        frame.size.height = self->m_fHeaderHeight;
        self.headerView.frame = frame;
        self.tableView.tableHeaderView = self.headerView;
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"item-%d-%@", (int)indexPath.row, [NSDate date]];
    return cell;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return m_fHeaderHeight;
//}
//
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return self.headerView;
//}


@end
