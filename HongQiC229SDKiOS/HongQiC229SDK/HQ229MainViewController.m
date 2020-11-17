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
#import "C229CAR_AFNetworking.h"
#import "NetWorkManager.h"
#define TopHeight 60
#import "C229NetWorkFailViewController.h"
#import "DetailViewController.h"
#import "C229ChooseModelViewController.h"
#import <WebKit/WebKit.h>
@interface HQ229MainViewController ()

@end

@implementation HQ229MainViewController
{
    UIScrollView *myScrollView;
    WKWebView *web;
    ThirdView *third;
    NSArray *settingArr;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
        return UIInterfaceOrientationLandscapeLeft;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
#pragma clang diagnostic ignored "-Wmismatched-return-types"
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#pragma clang diagnostic pop
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _carID = [NSString stringWithFormat:@"%@",dataDic[@"car_name"]];
    [self initNetWork];
}
- (void)initNetWork{
    NSString *oldUrl = [NSString stringWithFormat:@"hongqih9_admin/index.php?m=home&c=index&a=get_car_info&car_name="];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",oldUrl,_carID];
    
    [NetWorkManager requestGETSuperAPIWithURLStr:urlStr WithAuthorization:@"" paramDic:nil finish:^(id  _Nonnull responseObject) {
        settingArr = [responseObject objectForKey:@"type_list"];
        
       NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *chooseStr = [NSString stringWithFormat:@"%@ModelChoose",_carID];
       if (![user objectForKey:chooseStr]) {
           C229ChooseModelViewController *choose = [[C229ChooseModelViewController alloc] init];
           choose.carID = _carID;
           choose.settingArr = settingArr;
           [self presentViewController:choose animated:NO completion:nil];
       }else{
           
       }
        
    } enError:^(NSError * _Nonnull error) {
    
    } andShowLoading:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkNetWork];
    //background
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backGround setImage:[self createImageByName:@"homeBackground"]];
    [self.view addSubview:backGround];
    //topView
    TopTabView *top = [[TopTabView alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth-120, TopHeight)];
    top.carType = @"c229";
    [top reset];
    top.seleced = ^(NSInteger index) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"closeKeyboard" object:nil];
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
//    [self getJson];
}
- (void)checkNetWork{
    C229CAR_AFNetworkReachabilityManager *manager = [C229CAR_AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(C229CAR_AFNetworkReachabilityStatus status) {
            switch (status) {
                case C229CAR_AFNetworkReachabilityStatusUnknown:
                {
                    //未知网络
                    NSLog(@"未知网络");
                    C229NetWorkFailViewController *fail =
                    [[C229NetWorkFailViewController alloc] init];
                    [fail addBtn:1];
                    [self presentViewController:fail animated:NO completion:nil];
                }
                    break;
                case C229CAR_AFNetworkReachabilityStatusNotReachable:
                {
                    //无法联网
                    NSLog(@"无法联网");
                    C229NetWorkFailViewController *fail =
                    [[C229NetWorkFailViewController alloc] init];
                    [fail addBtn:1];
                    [self presentViewController:fail animated:NO completion:nil];
                }
                    break;

                
               
                    
            }
        }];
}
- (void)setScrollView{
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-TopHeight)];
    [self.view addSubview:myScrollView];
    myScrollView.contentSize = CGSizeMake(5*kScreenWidth, kScreenHeight-TopHeight);
    myScrollView.scrollEnabled = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.showsHorizontalScrollIndicator = NO;
    
    FirstView *first = [[FirstView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-TopHeight)];
    first.carID = self.carID;
    [myScrollView addSubview:first];
    first.jumpChooseModel = ^(NSDictionary * dic) {
        C229ChooseModelViewController *choose = [[C229ChooseModelViewController alloc] init];
        choose.carID = _carID;
        choose.settingArr = settingArr;
        [self presentViewController:choose animated:NO completion:nil];
    };
    first.jumpToDetail = ^(NSDictionary * dataDic) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };

    SecondView *second = [[SecondView alloc] initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight-TopHeight)];
    second.carID = self.carID;
    second.push = ^(NSDictionary * dataDic
                    ) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };
    [myScrollView addSubview:second];
//
    third = [[ThirdView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight-TopHeight)];
    third.dataDic = self.dataDic;
    third.jumpToDetail = ^(NSDictionary * dataDic) {
        if ([[NSString stringWithFormat:@"%@",dataDic[@"id"]] isEqualToString:@"213"]||[[NSString stringWithFormat:@"%@",dataDic[@"id"]] isEqualToString:@"205"]) {
            [self openNewWeb];
            return;
        }
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];

    };
    [myScrollView addSubview:third];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ForthView *forth = [[ForthView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-TopHeight)];
    forth.carID = self.carID;
    forth.push = ^(NSDictionary * dataDic) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };
    [myScrollView addSubview:forth];
//
    FifthView *fifth = [[FifthView alloc] initWithFrame:CGRectMake(kScreenWidth*4, 0, kScreenWidth, kScreenHeight-TopHeight)];
    fifth.carID = self.carID;
    fifth.push = ^(NSDictionary * dataDic) {
        DetailViewController *detail = [[DetailViewController alloc] init];
        self.definesPresentationContext = YES;
        detail.modalPresentationStyle =UIModalPresentationOverFullScreen;
        detail.dataDic = dataDic;
        [self presentViewController:detail animated:YES completion:nil];
    };
    [myScrollView addSubview:fifth];
}
- (void)closeAction{
    [web removeFromSuperview];
}
- (void)getJson{
    NSString *name = [NSString stringWithFormat:@"%@_category",self.carID];
    NSDictionary *dicOne = [self readLocalFileWithName:name];
    NSArray *dataArr = dicOne[@"RECORDS"];
    NSString *sqlStr = [self returnSqlKeys:dataArr[0]];
    
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
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}
-(void)openNewWeb{
        
        web = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];


        NSString *str = [NSString stringWithFormat:@"%@",_dataDic[@"game_web_url"]];
    
    
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
//         web.delegate = self;

        [self.view addSubview:web];
    web.backgroundColor = [UIColor blackColor];
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 19, 13, 19)];
        [closeBtn setImage:[self createImageByName:@"neirongguanbianniu"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [web addSubview:closeBtn];

        [web loadRequest:req];
}
@end
