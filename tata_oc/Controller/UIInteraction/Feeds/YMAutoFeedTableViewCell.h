//
//  YMAutoFeedTableViewCell.h
//  tata_oc
//
//  Created by yongming on 2018/11/26.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMFeedModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMAutoFeedTableViewCell : UITableViewCell

@property (nonatomic, strong) YMFeedModel* feedModel;

@end

NS_ASSUME_NONNULL_END
