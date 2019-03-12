//
//  YMFeedsFlowViewController.m
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMFeedsFlowViewController.h"
#import "YMFeedTableViewCell.h"

@interface YMFeedsFlowViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray<YMFeedModel*>* feeds;
@property (nonatomic, strong) NSArray* testCase;
@end

@implementation YMFeedsFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Feeds" ofType:@"plist"];
    self.testCase = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[YMFeedTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加新数据" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonClicked:)];
}

- (void)rightButtonClicked:(id)sender
{
    if (!self.feeds) {
        self.feeds = [NSMutableArray array];
    }
    
    NSString* string = self.testCase[arc4random() % self.testCase.count];
    
    YMFeedModel* model = [YMFeedModel feedWithString:string];
    [self.feeds addObject:model];
    
    [self.tableView reloadData];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMFeedTableViewCell* cell = (YMFeedTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    cell.contentView.backgroundColor = [UIColor redColor];
//    cell.textLabel.backgroundColor = [UIColor greenColor];
    
    YMFeedModel* model = (YMFeedModel*) self.feeds[indexPath.row];
    
//    cell.textLabel.numberOfLines = 0;
//    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.textLabel.font = [UIFont systemFontOfSize:model.fontSize];
//    cell.textLabel.text = model.stringContent;
//    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:model.stringContent];
    
//    NSLog(@"%@", model.stringContent);
    
    cell.feedModel = model;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feeds.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YMFeedModel* model = self.feeds[indexPath.row];
    
    return model.stringHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* string = self.testCase[arc4random() % self.testCase.count];
    YMFeedModel* model = [YMFeedModel feedWithString:string];
    
    [self.feeds replaceObjectAtIndex:indexPath.row withObject:model];
    
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
