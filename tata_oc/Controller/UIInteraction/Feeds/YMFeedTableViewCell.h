//
//  YMFeedTableViewCell.h
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMFeedTableViewCell : UITableViewCell

@property (nonatomic, strong) YMFeedModel* feedModel;

@end

NS_ASSUME_NONNULL_END
