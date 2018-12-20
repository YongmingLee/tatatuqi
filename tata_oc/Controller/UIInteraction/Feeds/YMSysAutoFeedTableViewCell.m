//
//  YMSysAutoFeedTableViewCell.m
//  tata_oc
//
//  Created by yongming on 2018/12/19.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMSysAutoFeedTableViewCell.h"

@interface YMSysAutoFeedTableViewCell()

@property (nonatomic, strong) UILabel* feedLabel;

@property (nonatomic, strong) UIView* redView;

@property (nonatomic, strong) MASConstraint* heightConstraint;

@end

@implementation YMSysAutoFeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            self.heightConstraint = make.height.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        int n = 100;
        
        CGFloat w = kScreenWidth / (n * 1.0);
        UIView* lastView;
        for (int i = 0; i < n; i ++) {
            
            UIView* view = [[UIView alloc] init];
            [self.contentView addSubview:view];
            
            view.backgroundColor = [UIColor randomColor];
            
            CGFloat h = (i == (n-1)) ? n : (arc4random() % n);
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(i*w);
                make.size.mas_equalTo(CGSizeMake(w, h));
                make.bottom.mas_equalTo(0);
            }];
            
            lastView = view;
        }
        
        [self.contentView addSubview:self.feedLabel];
        [self.feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.redView.mas_bottom);
            make.bottom.equalTo(lastView.mas_top);
        }];
    }
    
    return self;
}

- (void)setFeedModel:(YMFeedModel *)feedModel
{
    self.feedLabel.text = feedModel.stringContent;
    
    CGFloat height = feedModel.needDraw ? 60 : 0;
    
    self.heightConstraint.mas_equalTo(height);
}

- (UILabel*)feedLabel
{
    if (!_feedLabel) {
        _feedLabel = [[UILabel alloc] init];
        _feedLabel.font = [UIFont systemFontOfSize:14];
        _feedLabel.numberOfLines = 0;
        _feedLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _feedLabel;
}

- (UIView*)redView
{
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor randomColor];
    }
    return _redView;
}

@end
