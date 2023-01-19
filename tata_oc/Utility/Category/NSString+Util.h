//
//  NSString+Util.h
//  tata_oc
//
//  Created by yongming on 2021/9/18.
//  Copyright © 2021 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Util)
- (NSString *)ql_urlEncodedStringUsingEncoding:(NSStringEncoding)encoding;
@end

NS_ASSUME_NONNULL_END
