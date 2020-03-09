//
//  HQ229MainViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "HQ229MainViewController.h"
#import "TopTabView.h"
#import "AppFaster.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "ForthView.h"
#import "FifthView.h"
#define TopHeight 60

#import "DetailViewController.h"
#import "DownLoadViewViewController.h"
@interface HQ229MainViewController ()

@end

@implementation HQ229MainViewController
{
    UIScrollView *myScrollView;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //横屏
   // self.automaticallyAdjustsScrollViewInsets = NO;
    
//    if ( [[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)] ) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeLeft;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
    //background
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backGround setImage:[self createImageByName:@"homeBackground"]];
    [self.view addSubview:backGround];
    //topView
    TopTabView *top = [[TopTabView alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth-120, TopHeight)];
    [top reset];
    top.seleced = ^(NSInteger index) {
        myScrollView.contentOffset = CGPointMake(index *kScreenWidth, 0);
    };
    //closeBtn
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    [closeBtn setImage:[self createImageByName:@"CL_WDG_Status_Home_N"] forState:UIControlStateNormal];
    [closeBtn setImage:[self createImageByName:@"CL_WDG_Status_Home_P"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(goDonwLoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    [self.view addSubview:top];
    [self setScrollView];
    [self doDB];
    [self getJson];
}

- (void)setScrollView{
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-TopHeight)];
    [self.view addSubview:myScrollView];
    myScrollView.contentSize = CGSizeMake(5*kScreenWidth, kScreenHeight-TopHeight);
    myScrollView.scrollEnabled = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.showsHorizontalScrollIndicator = NO;
    
    FirstView *first = [[FirstView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-TopHeight)];
    [myScrollView addSubview:first];
    first.jumpToDetail = ^(NSDictionary * dataDic) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };
//    SecondView *second = [[SecondView alloc] initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight-TopHeight)];
//    [myScrollView addSubview:second];
    SecondView *second = [[SecondView alloc] initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight-TopHeight)];
    [myScrollView addSubview:second];
    
    ThirdView *third = [[ThirdView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight-TopHeight)];
    third.jumpToDetail = ^(NSDictionary * dataDic) {
//        DetailViewController *detail = [[DetailViewController alloc] init];
//        self.definesPresentationContext = YES;
//        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
//        detail.dataDic = dataDic;
//        [self presentViewController:detail animated:YES completion:nil];
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
        
        NSString *str = [resourceBundle pathForResource:@"web_mobile/index" ofType:@"html"];
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        web.delegate = self;
        
        [self.view addSubview:web];
        
        [web loadRequest:req];
    };
    [myScrollView addSubview:third];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ForthView *forth = [[ForthView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-TopHeight)];
    forth.push = ^(NSDictionary * dataDic) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };
    [myScrollView addSubview:forth];
    
    FifthView *fifth = [[FifthView alloc] initWithFrame:CGRectMake(kScreenWidth*4, 0, kScreenWidth, kScreenHeight-TopHeight)];
    
    [myScrollView addSubview:fifth];
}
- (void)getJson{
    NSDictionary *dicOne = [self readLocalFileWithName:@"zy_category"];
    NSArray *dataArr = dicOne[@"RECORDS"];
    NSString *sqlStr = [self returnSqlKeys:dataArr[0]];
    
//    for (NSDictionary *dic in dataArr) {
//        [db open];
//
//        NSMutableString *wenhao = [NSMutableString string];
//        for (NSString *key in [dic allKeys]) {
//            wenhao = [wenhao stringByAppendingFormat:@"?,"];
//        }
//        NSString *wenhaoLL = [wenhao substringToIndex:wenhao.length-1];
//
//        NSString *sqlInsert = [NSString stringWithFormat:@"insert into 'category'(%@) values(%@)",[self sqlKeys:[dic allKeys]],wenhaoLL];
//
//        BOOL result = [db executeUpdate:sqlInsert withArgumentsInArray:[self sqlValues:dic andKeyArr:[dic allKeys]]];
//        if (result) {
//
//        } else {
//
//        }
//        [db close];
//    }
    
    //创建表
//    [db open];
//    if (![db open]) {
//        NSLog(@"db open fail");
//        return;
//    }
//    //4.数据库中创建表（可创建多张）
//    NSString *sqlCreate = [NSString stringWithFormat:@"create table if not exists category (%@)",sqlStr];
//    //5.执行更新操作 此处database直接操作，不考虑多线程问题，多线程问题，用FMDatabaseQueue 每次数据库操作之后都会返回bool数值，YES，表示success，NO，表示fail,可以通过 @see lastError @see lastErrorCode @see lastErrorMessage
//    BOOL result = [db executeUpdate:sqlCreate];
//    if (result) {
//        NSLog(@"create table success");
//
//    }
//    [db close];
//创建表
    
}
- (void)doDB{
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"category.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
     //2.创建对应路径下数据库
//    db = [FMDatabase databaseWithPath:dbPath];
    //3.在数据库中进行增删改查操作时，需要判断数据库是否open，如果open失败，可能是权限或者资源不足，数据库操作完成通常使用close关闭数据库
    
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
- (NSString *)returnSqlKeys:(NSDictionary *)dic{
    
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in [dic allKeys]) {
        NSString *new = [NSString stringWithFormat:@"'%@' TEXT NOT NULL,",key];
        str = [str stringByAppendingFormat:@"%@", new];
    }
    NSString *last = [NSString stringWithFormat:@"%@",str];
    
    return [last substringToIndex:last.length-1];
}
- (NSString *)sqlKeys:(NSArray *)keys{
    NSMutableString *keyStr = [NSMutableString string];
    for (NSString *str in keys) {
        keyStr = [keyStr stringByAppendingFormat:@"%@,",str];
    }
    return [keyStr substringToIndex:keyStr.length-1];
}
- (NSArray *)sqlValues:(NSDictionary *)dataDic andKeyArr:(NSArray *)keyArr{
    NSMutableArray *valueArr = [NSMutableArray array];
    for (NSString *key in keyArr) {
        NSString *value = [NSString stringWithFormat:@"%@",dataDic[key]];
        [valueArr addObject:value];
    }
    return valueArr;
}
- (void)goDonwLoad{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];
//    DownLoadViewViewController *vc = [[DownLoadViewViewController alloc] init];
//    self.definesPresentationContext = YES;
//    vc.modalPresentationStyle =UIModalPresentationOverFullScreen;
//    [self presentViewController:vc animated:NO completion:nil];
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}

@end
