//
//  YMAIChatQQ.m
//  tata_oc
//
//  Created by yongming on 2018/8/17.
//  Copyright © 2018 yongming. All rights reserved.
//

#import "YMAIChatQQ.h"
#import <CommonCrypto/CommonDigest.h>

@implementation YMAIChatQQ


- (void)sendChatMsg:(NSString*)msg
{
    //获取当前时间戳
    NSDate *currentTime = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [currentTime timeIntervalSince1970];
    NSString *currentStr = [NSString stringWithFormat:@"%.0f",time];
    NSLog(@"当前的时间戳是%@",currentStr);
    
    NSMutableDictionary *mudic2 = [NSMutableDictionary dictionary];
    [mudic2 setObject:@"2107740563" forKey:@"app_id"];
    [mudic2 setObject:@"10000" forKey:@"session"];
    [mudic2 setObject:currentStr forKey:@"time_stamp"];
    [mudic2 setObject:@"o1w5w2rov3" forKey:@"nonce_str"];
    NSString* tt = msg;
    [mudic2 setObject:tt forKey:@"question"];
    
    NSString* signStr = [self jlGetSignData:mudic2 withAppKey:@"WUX1XA2TQLRR7CpQ"];
    
    [mudic2 removeObjectForKey:@"question"];
    NSString *question = [tt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];;
    [mudic2 setObject:question forKey:@"question"];
    
    [mudic2 setObject:signStr forKey:@"sign"];
    
    [self netWorkTest2:mudic2];
}

//计算鉴权值
- (NSString*)jlGetSignData:(NSMutableDictionary*)dic withAppKey:(NSString*)appKey
{
    NSArray *allKeys = [dic allKeys];
    NSArray *sortArr = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSLog(@"sortArr is %@",sortArr);
    NSMutableArray *valueArr = [NSMutableArray array];
    for (NSString *sortString in sortArr) {
        NSString *valueStr = [dic objectForKey:sortString];
        NSString *urlEncode=  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef)valueStr,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
        [valueArr addObject:urlEncode];
    }
    NSLog(@"valueArr is %@",valueArr);
    NSMutableArray *signArr = [NSMutableArray array];
    for (int i = 0; i < sortArr.count; i ++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArr[i],valueArr[i]];
        [signArr addObject:keyValueStr];
    }
    
    NSString *sign = [signArr componentsJoinedByString:@"&"];
    
    NSLog(@"最终拼接的字符串是%@",sign);
    
    NSMutableString *muStr = [NSMutableString string];
    [muStr appendString:sign];
    [muStr appendString:[NSString stringWithFormat:@"&app_key=%@",appKey]];
    NSLog(@"MD5运算的源数据是%@",muStr);
    
    NSString *secStr =  [self md5:muStr];
    NSString *upperSec = [secStr uppercaseString];
    NSLog(@"MD5加密的结果是%@",secStr);
    
    return upperSec;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    NSLog(@"md5参数是%s",cStr);
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (void)netWorkTest2:(NSMutableDictionary *)mudic
{
    NSLog(@"接口请求参数是%@",mudic);
    NSString *testURL = @"https://api.ai.qq.com/fcgi-bin/nlp/nlp_textchat?";
    NSArray *keys = [mudic allKeys];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i <keys.count; i ++) {
        NSString *key = [keys objectAtIndex:i ];
        NSString *value = [mudic objectForKey:key];
        NSString *com = [[NSString alloc]initWithFormat:@"%@=%@",key,value ];
        [arr addObject:com];
        
    }
    NSString *sign = [arr componentsJoinedByString:@"&"];
    NSMutableString *mustr = [NSMutableString string];
    [mustr appendString:testURL];
    [mustr appendString:sign];
    NSLog(@"完整的请求参数是%@",mustr);
    testURL = [mustr  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:mustr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方法
    request.HTTPMethod = @"POST";
    
    
    NSURLSession *session  = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask =  [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //
        if (error) {
            NSLog(@"error is %@",error);
        }else
        {
            NSLog(@"data is %@",data);
            NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"解析得出的dic is %@",dic);
            NSLog(@"答案是：%@", dic[@"data"][@"answer"]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate msgDidResponse:dic[@"data"][@"answer"]];
            });
        }
    }];
    [dataTask resume];
}

@end
