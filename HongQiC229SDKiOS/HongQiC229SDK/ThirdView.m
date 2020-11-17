//
//  ThirdView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ThirdView.h"
#import <WebKit/WebKit.h>
@implementation ThirdView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    [self setWebView];
}
- (void)setWebView{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:CGRectMake(-50, 0, self.frame.size.width+100, self.frame.size.height+50)];


//    if (@available(iOS 11.0, *)) {
//        web.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }

    web.UIDelegate = self;
    web.navigationDelegate = self;
    NSURLRequest *reqWeb = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataDic[@"trim_web_url"]]]];

    [self addSubview:web];
    self.clipsToBounds = YES;
    [web loadRequest:reqWeb];

}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
   NSLog(@"6->在收到响应后，决定是否跳转");
   NSLog(@"navigationResponse = %@", navigationResponse);
   NSLog(@"navigationResponse.response = %@", navigationResponse.response);
   // 必须实现decisionHandler的回调，否则就会报错
   decisionHandler(WKNavigationResponsePolicyAllow);
   NSLog(@"WKNavigationResponsePolicyAllow");

    NSString *str = [NSString stringWithFormat:@"%@",navigationResponse.response.URL.host];
        if ([str containsString:@"JsTest="]) {
            NSString *newId = [str substringFromIndex:7];
    
            NSLog(@"%@",newId);
            NSDictionary *all = [self readLocalFileWithName:[NSString stringWithFormat:@"%@_news",_dataDic[@"car_name"]]];
            NSArray *array = [all objectForKey:@"RECORDS"];
    
            for (NSDictionary *d in array) {
                NSString *tid = [NSString stringWithFormat:@"%@",d[@"id"]];
                if ([tid isEqualToString:newId]) {
                    self.jumpToDetail(d);
                }
            }
        }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
// 设置字体
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='Arial';";
    [webView evaluateJavaScript:fontFamilyStr completionHandler:nil];
//设置颜色
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#9098b8'" completionHandler:nil];
//修改字体大小
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"completionHandler:nil];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        decisionHandler(WKNavigationActionPolicyCancel);
        NSLog(@"WKNavigationActionPolicyCancel");
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
        NSLog(@"WKNavigationActionPolicyAllow");
        
    }

//    NSString * urlStr = navigationAction.request.URL.absoluteString;
        NSString *str = [NSString stringWithFormat:@"%@",navigationAction.request.URL.host];
        if ([str containsString:@"JsTest="]) {
            NSString *newId = [str substringFromIndex:7];
    
            NSLog(@"%@",newId);
            NSDictionary *all = [self readLocalFileWithName:[NSString stringWithFormat:@"%@_news",_dataDic[@"car_name"]]];
            NSArray *array = [all objectForKey:@"RECORDS"];
    
            for (NSDictionary *d in array) {
                NSString *tid = [NSString stringWithFormat:@"%@",d[@"id"]];
                if ([tid isEqualToString:newId]) {
                    self.jumpToDetail(d);
                }
            }
        }
    
}


- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    // 获取文件路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileDir = [docDir stringByAppendingPathComponent:@""];
    NSString *filePath = [fileDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",name]];
    NSString *path = [resourceBundle pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:filePath];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    // 对数据进行JSON格式化并返回字典形式
    if (!data) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!error) {
        return dic;
    }else{
        return nil;
    }
}

@end
