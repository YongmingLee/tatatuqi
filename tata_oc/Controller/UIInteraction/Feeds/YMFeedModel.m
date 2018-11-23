//
//  YMFeedModel.m
//  tata_oc
//
//  Created by yongming on 2018/11/23.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMFeedModel.h"

@implementation YMFeedModel

+ (YMFeedModel*)feedWithString:(NSString*)string
{
    YMFeedModel* model = [[YMFeedModel alloc] init];
    model.stringContent = string;
    model.fontSize = 14;
    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:model.fontSize]
//                                                                  forKey:NSFontAttributeName];
//
//    CGSize size = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 60, MAXFLOAT)
//                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
//                                    attributes:dic
//                                       context:nil].size;
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
//    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:model.fontSize], NSParagraphStyleAttributeName : style };
    
    NSDictionary *attributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:model.fontSize]};
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 0, MAXFLOAT)
                                       options:opts
                                  attributes:attributes
                                     context:nil];
    
    model.stringHeight = ceil(rect.size.height) + 10; //rect.size.height;//
    
    return model;
}

@end
