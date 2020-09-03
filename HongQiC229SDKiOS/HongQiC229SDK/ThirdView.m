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
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setWebView];
    }
    
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
    
    NSURLRequest *reqWeb = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.haoweisys.com/c229_360/"]];

    [self addSubview:web];
    self.clipsToBounds = YES;
    [web loadRequest:reqWeb];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *str = [NSString stringWithFormat:@"%@",request.URL.host];
    if ([str containsString:@"JsTest="]) {
        NSString *newId = [str substringFromIndex:7];
        
        NSLog(@"%@",newId);
        NSDictionary *all = [self readLocalFileWithName:@"229_news"];
        NSArray *array = [all objectForKey:@"RECORDS"];
        
        for (NSDictionary *d in array) {
            NSString *tid = [NSString stringWithFormat:@"%@",d[@"id"]];
            if ([tid isEqualToString:newId]) {
                self.jumpToDetail(d);
            }
        }
    }
    
    return YES;
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
