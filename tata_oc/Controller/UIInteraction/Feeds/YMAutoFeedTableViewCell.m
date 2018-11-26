//
//  YMAutoFeedTableViewCell.m
//  tata_oc
//
//  Created by yongming on 2018/11/26.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAutoFeedTableViewCell.h"


@interface YMAutoFeedTableViewCell()

@property (nonatomic, strong) UILabel* feedLabel;

@property (nonatomic, strong) UIView* redView;

@end

@implementation YMAutoFeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.redView];
        [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.height.mas_equalTo(0);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
        }];
        
        [self.contentView addSubview:self.feedLabel];
        [self.feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.top.equalTo(self.redView.mas_bottom);
        }];
    }
    
    return self;
}

- (void)setFeedModel:(YMFeedModel *)feedModel
{
    self.feedLabel.text = feedModel.stringContent;
    
    [self.redView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(feedModel.needDraw ? 60 : 0);
    }];
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
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

@end
