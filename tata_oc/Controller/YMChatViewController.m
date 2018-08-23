//
//  ViewControllerChat.m
//  tata_oc
//
//  Created by yongming on 2018/8/17.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMChatViewController.h"
#import <Masonry/Masonry.h>
#import "YMAIChatQQ.h"

@interface ChatModel : NSObject
@property (nonatomic, strong) NSString* msg;
@property (nonatomic, assign) BOOL isMe;
@end
@implementation ChatModel
@end

@interface YMChatViewController () <UITableViewDelegate, UITableViewDataSource, YMAIChatQQDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UITextField* textField;
@property (nonatomic, strong) NSMutableArray* chats;
@property (nonatomic, strong) YMAIChatQQ* chatEngine;
@end

@implementation YMChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField* txt = [[UITextField alloc] init];
    txt.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:txt];
    txt.placeholder = @"说点什么...";
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(6);
        make.top.mas_equalTo(84);
        make.right.equalTo(self.view).offset(-6);
        make.height.mas_equalTo(30);
    }];
    
    self.textField = txt;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(sendAction)];
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(txt.mas_bottom).offset(5);
        make.height.mas_equalTo(200);
    }];
    
    self.chats = [NSMutableArray array];
    self.tableView = tableView;
    
    [self.textField becomeFirstResponder];
}

- (YMAIChatQQ*)chatEngine
{
    if (!_chatEngine) {
        _chatEngine = [[YMAIChatQQ alloc] init];
        _chatEngine.delegate = self;
    }
    return _chatEngine;
}

- (void)sendAction
{
    ChatModel* model = [ChatModel new];
    model.msg = [NSString stringWithFormat:@"问:%@", self.textField.text];
    model.isMe = YES;
    
    [self.chats addObject:model];
    
    [self.chatEngine sendChatMsg:model.msg];
    
    [self.tableView reloadData];
    
    NSIndexPath* index = [NSIndexPath indexPathForRow:(self.chats.count - 1) inSection:0];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)msgDidResponse:(NSString *)msg
{
    if (msg && msg.length > 0) {
        
        ChatModel* model = [ChatModel new];
        model.msg = [NSString stringWithFormat:@"答:%@", msg];
        model.isMe = NO;
        
        [self.chats addObject:model];
        [self.tableView reloadData];
        
        NSIndexPath* index = [NSIndexPath indexPathForRow:(self.chats.count - 1) inSection:0];
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        self.textField.text = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chats.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ChatModel* model = self.chats[indexPath.row];
    cell.textLabel.text = model.msg;
    cell.textLabel.textColor = model.isMe ? [UIColor blueColor] : [UIColor orangeColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
