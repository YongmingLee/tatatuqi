//
//  YMRoundCellTestViewController.m
//  tata_oc
//
//  Created by yongming on 2020/12/18.
//  Copyright © 2020 yongming. All rights reserved.
//

#import "YMRoundCellTestViewController.h"

const CGFloat ROUNDCELL_GAP = 8;
const CGFloat ROUNDCELL_CORNER = 14;
const CGFloat ROUNDCELL_ROWHEIGHT = 48;
NSString* CELLID_AVATAR = @"cell_avatar";
NSString* CELLID_ALBUM = @"cell_album";
NSString* CELLID_NORMAL = @"cell_normal";


/********************************************************************
 标题头
 *********************************************************************/
@interface YMRoundTableHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel* titlelabel;
@end

@implementation YMRoundTableHeaderView
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel* titlelabel = [[UILabel alloc] init];
        [self.contentView addSubview:titlelabel];
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(24);
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(-24);
        }];
        self.titlelabel = titlelabel;
    }
    return self;
}
@end

/********************************************************************
 自定义Cell
 *********************************************************************/
@interface YMRoundTableCell : UITableViewCell

// normal
@property (nonatomic, strong) UILabel* titlelabel;
@property (nonatomic, strong) UITextField* contentTextField;

// avatar
@property (nonatomic, strong) UIButton* avatarButton;

// album
@property (nonatomic, strong) NSMutableArray* albumButtons;

@end

@implementation YMRoundTableCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([reuseIdentifier isEqualToString:CELLID_NORMAL]) {
            
            UILabel* titlelabel = [[UILabel alloc] init];
            [self.contentView addSubview:titlelabel];
            [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(24);
                make.centerY.equalTo(self.contentView);
            }];
            
            UITextField* contentTextField = [[UITextField alloc] init];
            [self.contentView addSubview:contentTextField];
            [contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(88);
                make.centerY.equalTo(self.contentView);
            }];
            
            titlelabel.font = [UIFont systemFontOfSize:14];
            titlelabel.textColor = UIColorFromHEX(0x84899B);
            
            contentTextField.font = [UIFont systemFontOfSize:14];
            contentTextField.textColor = UIColorFromHEX(0x222222);
            [contentTextField setEnabled:NO];
            contentTextField.returnKeyType = UIReturnKeyDone;
            
            self.titlelabel = titlelabel;
            self.contentTextField = contentTextField;
            self.contentView.backgroundColor = [UIColor whiteColor];
            
        } else if ([reuseIdentifier isEqualToString:CELLID_AVATAR]) {
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            
            UIButton* avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:avatarButton];
            [avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
                make.size.mas_equalTo(CGSizeMake(126, 126));
            }];
            avatarButton.layer.masksToBounds = YES;
            avatarButton.layer.cornerRadius = 16;
            self.avatarButton = avatarButton;
            
            // 编辑按钮
            UIImageView* imageEdit = [[UIImageView alloc] init];
            [avatarButton addSubview:imageEdit];
            [imageEdit mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(36, 36));
            }];
            
            avatarButton.backgroundColor = [UIColor redColor];
            imageEdit.backgroundColor = [UIColor greenColor];
            
        } else if ([reuseIdentifier isEqualToString:CELLID_ALBUM]) {
            self.contentView.backgroundColor = [UIColor whiteColor];
            
            self.albumButtons = [NSMutableArray array];
            CGFloat gap = (kScreenWidth - 48 - 4 * 76) * 1.0 / 3.0;
            for (int i = 0; i < 4; i ++) {
                
                // 相册
                UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:@"+" forState:UIControlStateNormal];
                [self.contentView addSubview:button];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(76, 100));
                    make.left.mas_equalTo(24 + i * 76 + i * gap);
                }];
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 16;

                // 删除按钮
                UIImageView* imageDelete = [[UIImageView alloc] init];
                [button addSubview:imageDelete];
                [imageDelete mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.right.mas_equalTo(0);
                    make.size.mas_equalTo(CGSizeMake(18, 18));
                }];


                [self.albumButtons addObject:@{@"button":button, @"image":imageDelete}];
                
                
                // Debug
                button.backgroundColor = [UIColor redColor];
                imageDelete.backgroundColor = [UIColor greenColor];
            }
        }
        
    }
    return self;
}

/// 更新头像地址
/// @param url 头像链接
- (void)updateAvatar:(NSString* )url {
    
}

/// 更新相册
/// @param albums 相册信息
- (void)updateAlbums:(NSArray*)albums {
    if (albums.count > 0) {
        
    }
    
    NSDictionary* info = self.albumButtons[2];
    UIImageView* imageDelete = info[@"image"];
    if (imageDelete) {
        imageDelete.hidden = YES;
    }
}

@end

/********************************************************************
 测试VC
 *********************************************************************/
@interface YMRoundCellTestViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (nonatomic, strong) NSArray* cellDatas;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation YMRoundCellTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellDatas =
    @[
        @[@{@"name":@"avatar"}],
        @[@{@"name":@"album"}],
        @[@{@"name":@"昵称", @"placeholder":@"请输入昵称"},
          @{@"name":@"性别", @"placeholder":@"点击选择性别"},
          @{@"name":@"城市", @"placeholder":@"点击选择所在的城市"},
          @{@"name":@"身高", @"placeholder":@"点击选择身高"},
          @{@"name":@"体重", @"placeholder":@"点击选择体重"},
          @{@"name":@"生日", @"placeholder":@"点击选择生日"},
          @{@"name":@"星座", @"placeholder":@"选择生日后自动生成"}],
        @[@{@"name":@"语音签名", @"placeholder":@"点击录制"},
          @{@"name":@"文字签名", @"placeholder":@"有趣的介绍会获得更多匹配，点击填写"}]
    ];
    
    [self updateUI];
}

// 更新UI
- (void)updateUI {
    
    self.title = @"编辑资料";
    
    UIButton* saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:UIColorFromHEX(0xFE634D) forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 32);
    [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton setTitleColor:UIColorFromHEX(0xFE634D) forState:UIControlStateNormal];
    backButton.contentMode = UIViewContentModeLeft;
    [backButton setBackgroundColor:[UIColor blackColor]];
    [backButton addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItems = @[backButtonItem];
    
    UITableView* tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = UIColorFromHEX(0xF3F2F6);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableview registerClass:[YMRoundTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"YMRoundTableHeaderView"];
    
    // 注册子cell
    [tableview registerClass:[YMRoundTableCell class] forCellReuseIdentifier:CELLID_AVATAR];
    [tableview registerClass:[YMRoundTableCell class] forCellReuseIdentifier:CELLID_ALBUM];
    [tableview registerClass:[YMRoundTableCell class] forCellReuseIdentifier:CELLID_NORMAL];
    
    self.tableView = tableview;
}

- (void)backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveButtonClicked {
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了确定...");
    }];
    UIAlertController* controller = [UIAlertController alertControllerWithTitle:@"标题" message:@"确定要保存吗？" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
}

/// 是否需要画圆角
/// @param section index
- (BOOL)sectionCornerShouldBeDraw:(NSInteger)section {
    return (section == 1 || section == 2);
}

#pragma mark - UITableView

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* cellIdentifier;
    if (indexPath.section == 0) {
        cellIdentifier = CELLID_AVATAR;
    } else if (indexPath.section == 1) {
        cellIdentifier = CELLID_ALBUM;
    } else {
        cellIdentifier = CELLID_NORMAL;
    }
    
    YMRoundTableCell* cell = (YMRoundTableCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 2 || indexPath.section == 3) {
        NSDictionary* info = self.cellDatas[indexPath.section][indexPath.row];
        if (info) {
            cell.titlelabel.text = info[@"name"];
            cell.contentTextField.placeholder = info[@"placeholder"];
        }
    } else {
        
        if (indexPath.section == 1) {
            [cell updateAlbums:nil];
        }
    }
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* rows = self.cellDatas[section];
    return rows.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3) {
        return ROUNDCELL_ROWHEIGHT;
    } else if (indexPath.section == 0) {
        return 158;
    } else {
        return 116;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 2 && indexPath.row == 0) {

        YMRoundTableCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

        cell.contentTextField.delegate = self;
        [cell.contentTextField setEnabled:YES];
        [cell.contentTextField becomeFirstResponder];
        
    } else {
        [self.view endEditing:YES];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellDatas.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YMRoundTableHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YMRoundTableHeaderView"];
    NSString* titlestring;
    if (section == 1) {
        titlestring = @"相册";
    } else if (section == 2) {
        titlestring = @"我的信息";
    }
    if ([self sectionCornerShouldBeDraw:section]) {
        headerView.titlelabel.textAlignment = NSTextAlignmentLeft;
        headerView.titlelabel.text = titlestring;
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        headerView.titlelabel.textColor = UIColorFromHEX(0x222222);
        headerView.titlelabel.font = [UIFont boldSystemFontOfSize:16];
    } else {
        headerView.contentView.backgroundColor = [UIColor clearColor];
        headerView.titlelabel.textColor = UIColorFromHEX(0xB6B6C4);
        headerView.titlelabel.font = [UIFont boldSystemFontOfSize:12];
        if (section == 0) {
            headerView.titlelabel.textAlignment = NSTextAlignmentCenter;
            headerView.titlelabel.text = @"资料完成度越高，越容易获得Ta的青睐哦～";
        }
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 49;
    }
    else if (section == 1 || section == 2)
        return 46;
    return 0;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //圆率
    CGFloat cornerRadius = ROUNDCELL_CORNER;
    //大小
    CGFloat gap = ROUNDCELL_GAP;
    CGRect bounds = CGRectInset(cell.bounds, gap, 0); //cell.bounds;
    
    //行数
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    UIView *headerView;
    if ([self respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        headerView = [self tableView:tableView viewForHeaderInSection:indexPath.section];
    }
    
    //绘制曲线
    UIBezierPath *bezierPath = nil;
    if (headerView && [self sectionCornerShouldBeDraw:indexPath.section]) {
        if (indexPath.row == 0 && numberOfRows == 1) {
            //一个为一组时，四个角都为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }else
            if (indexPath.row == numberOfRows - 1) {
                //为组的最后一行，左下、右下角为圆角
                bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            } else {
                //中间的都为矩形
                bezierPath = [UIBezierPath bezierPathWithRect:bounds];
            }
    }else{
        if (indexPath.row == 0 && numberOfRows == 1) {
            //一个为一组时，四个角都为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == 0) {
            //为组的第一行时，左上、右上角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == numberOfRows - 1) {
            //为组的最后一行，左下、右下角为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else {
            //中间的都为矩形
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
    }
    
    //新建一个图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    //图层边框路径
    layer.path = bezierPath.CGPath;
    cell.layer.mask=layer;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self sectionCornerShouldBeDraw:section]) {
        //圆率
        CGFloat cornerRadius = ROUNDCELL_CORNER;
        //大小
        CGFloat gap = ROUNDCELL_GAP;
        CGRect bounds = CGRectInset(view.bounds, gap, 0);
        
        //绘制曲线
        UIBezierPath *bezierPath = nil;
        //为组的第一行时，左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        //新建一个图层
        CAShapeLayer *layer = [CAShapeLayer layer];
        //图层边框路径
        layer.path = bezierPath.CGPath;
        view.layer.mask=layer;
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    YMRoundTableCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        [cell.contentTextField setEnabled:NO];
    }
    return YES;
}

@end
