//
//  C229NetWorkFailViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/4/10.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import "C229NetWorkFailViewController.h"
#import "AppManager.h"
#import "AppFaster.h"

@interface C229NetWorkFailViewController ()

@end

@implementation C229NetWorkFailViewController
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUILayer];
}
- (void)setUILayer{
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [back setImage:[AppManager createImageByName:@"C229NetFailbackGround"]];
    [self.view addSubview:back];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-170)/2, (kScreenHeight-136)/2-30, 170, 136)];
    [logo setImage:[AppManager createImageByName:@"c229netfailLogo"]];
    [self.view addSubview:logo];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenHeight-136)/2-30+136+15, kScreenWidth, 15)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"网络异常，请检查网络！";
    [self.view addSubview:label];
    
}
- (void)addBtn:(NSInteger)x{
    if (x==1) {
        UIButton *centerBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-80)/2, kScreenHeight-45-20, 80, 30)];
        [centerBtn setTitle:@"确认" forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:[AppManager createImageByName:@"c229failBtnBlue"] forState:UIControlStateNormal];
        [self.view addSubview:centerBtn];
        [centerBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }else{
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-80-10, kScreenHeight-45-20, 80, 30)];
        [leftBtn setTitle:@"重试" forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[AppManager createImageByName:@"c229failBtnBlue"] forState:UIControlStateNormal];
        [self.view addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2+10, kScreenHeight-45-20, 80, 30)];
        [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:[AppManager createImageByName:@"c229failBtnBlack"] forState:UIControlStateNormal];
        [self.view addSubview:rightBtn];
        [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)dismiss{
    [self dismissViewControllerAnimated:NO completion:  nil];
}
- (void)leftAction{
    if (self) {
        self.retry(@"x");
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
- (void)rightAction{
    if (self) {
//        self.back(@"x");
        [self dismissViewControllerAnimated:NO completion:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];
    }
}
@end
