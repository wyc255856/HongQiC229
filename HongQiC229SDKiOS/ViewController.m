//
//  ViewController.m
//  HongQiH5SDKiOS
//
//  Created by Yu Chen on 2018/7/11.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "ViewController.h"
#import "HQ229MainViewController.h"
#import "C229LoadingViewController.h"
#import "E115LoadingViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 44)];
    [button setTitle:@"229" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1.0;
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 280, 100, 44)];
    [button1 setTitle:@"115" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(e115buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.borderWidth = 1.0;
    [self.view addSubview:button1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"C229NotificationPortrait" object:nil];

    
}

- (void)buttonClicked {

    C229LoadingViewController *vc = [[C229LoadingViewController alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:NO completion:nil];
    
}
- (void)e115buttonClick{
    E115LoadingViewController *vc = [[E115LoadingViewController alloc] init];
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
* @brief   接收通知(BYNotificationTest)
* @param   note NSNotification通知对象
*/
- (void)handleNotification:(NSNotification *)note
{
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
        [appDelegate setNewOrientation:NO];//调用转屏代码
}

@end
