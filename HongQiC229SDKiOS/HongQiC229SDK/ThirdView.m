//
//  ThirdView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ThirdView.h"

@implementation ThirdView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self setWebView];
    return self;
    
}
- (void)setWebView{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(-50, 0, self.frame.size.width+100, self.frame.size.height+50)];
  
            
//    if (@available(iOS 11.0, *)) {
//        web.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
        
    NSString *str = [resourceBundle pathForResource:@"pano_2/index" ofType:@"html"];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    web.delegate = self;
    
    [self addSubview:web];
    self.clipsToBounds = YES;
    [web loadRequest:req];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *str = [NSString stringWithFormat:@"%@",request.URL.host];
    if ([str containsString:@"JsTest="]) {
        [str substringFromIndex:6];
        NSLog(@"%@",str);
//        NSDictionary *all = [self readLocalFileWithName:@"229_news"];
//        NSArray *array = [all objectForKey:@"RECORDS"];
        self.jumpToDetail(nil);
//        for (NSDictionary *d in array) {
//            NSString *caid = [NSString stringWithFormat:@"%@",d[@"caid"]];
//            if ([caid isEqualToString:@"1896"]) {
//                self.jumpToDetail(d);
//            }
//        }
    }
    
    return YES;
}

- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    // 获取文件路径
    NSString *path = [resourceBundle pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!error) {
        return dic;
    }else{
        return nil;
    }
}

@end
