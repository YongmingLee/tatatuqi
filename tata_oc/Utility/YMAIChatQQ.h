//
//  YMAIChatQQ.h
//  tata_oc
//
//  Created by yongming on 2018/8/17.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YMAIChatQQDelegate <NSObject>

- (void)msgDidResponse:(NSString*)msg;

@end

@interface YMAIChatQQ : NSObject

- (void)sendChatMsg:(NSString*)msg;

@property (nonatomic, assign) id <YMAIChatQQDelegate> delegate;

@end


