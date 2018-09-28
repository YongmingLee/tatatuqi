//
//  YMFunc.h
//  tata_oc
//
//  Created by yongming on 2018/9/26.
//  Copyright © 2018 yongming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMFunc : NSObject

/**
 调用类的方法

 @param class 类名
 @param selector 方法指针
 @param target 类实例
 @param params 参数数组
 @return 返回值
 
 用例：
 id rs = [YMFunc callFromClass:[YMRightTableViewController class] selector:@selector(test123:name:) target:self.rViewVC params:@[@123,@"asdf"]];
 ...
 
 */
+ (id)callFromClass:(Class)class selector:(SEL)selector target:(id)target params:(NSArray*)params;

@end

NS_ASSUME_NONNULL_END
