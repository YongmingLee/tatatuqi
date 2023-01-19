//
//  YMWebViewController.m
//  tata_oc
//
//  Created by yongming on 2021/9/18.
//  Copyright © 2021 yongming. All rights reserved.
//

#import "YMWebViewController.h"
#import <WebKit/WebKit.h>

@interface YMWebViewController ()
@property (nonatomic, strong)WKWebView* webview;
@end

@implementation YMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}

- (void)updateUI {
    self.webview = [[WKWebView alloc] init];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSString* str = @"http://service.static.kele55.com/activity/2021/luckDrawMobile/index.html?uid=994101&authtoken=Go/XdnYGRVmN5qoLenwa3KoC4mlO7mHR7piMXCA4bZxbEb+WpuYl8fPYeQPd1LfaB5gt/VK9lnjM28BynlXsKHtmQuUjNIk6AfW+Q2wiYnC3iWosOuI614Bpi7TLv1/0ZoVOqLymhzeliGYknqQim4GA61+P7rkaft1cwIaps5d1n+7FwitYkc7aHR+OgTxVvFTXSg5abhKGhl91p9bVRVd/GRiu45ASRhlAJWkiXgFG6qF+azueqIrpmmGLXfEHa3z1mRfaPvZ/odMg7ZKdXsx8oCZdUpjZKEsS3GJM14uSCkX/JkEj8DrlhWGoYZXTZtRxN4hbpcJK2MjVIHQWDQ==|994101|%u5c0f%u5471|2|1569485756866&roomid=20000&anchorid=0&oemid=87";
    
    NSLog(@"%@", str);
    
    str = @"https://weibo.com/newlogin?tabtype=list&gid=1028039999&url=https%3A%2F%2Fweibo.com%2Fhot%2Flist%2F1028039999";
    
    
    NSURL* url = [NSURL URLWithString:str];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

@end
