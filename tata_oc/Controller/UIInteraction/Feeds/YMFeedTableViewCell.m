//
//  YMFeedTableViewCell.m
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMFeedTableViewCell.h"

@interface YMFeedTableViewCell()

@property (nonatomic, strong) UILabel* feedLabel;

@end

@implementation YMFeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.feedLabel = [[UILabel alloc] init];
        self.feedLabel.font = [UIFont systemFontOfSize:14];
        self.feedLabel.numberOfLines = 0;
        self.feedLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.contentView addSubview:self.feedLabel];
        
        [self.feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)setFeedModel:(YMFeedModel *)feedModel
{
    self.feedLabel.text = feedModel.stringContent;
}

@end
