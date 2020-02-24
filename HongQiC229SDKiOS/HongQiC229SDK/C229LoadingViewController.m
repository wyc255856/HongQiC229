//
//  C229LoadingViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/2/20.
//  Copyright © 2020 Parry. All rights reserved.
//

#import "C229LoadingViewController.h"
#import "AppFaster.h"
#import "HQ229MainViewController.h"
@interface C229LoadingViewController ()

@end

@implementation C229LoadingViewController
{
    NSTimer *timer;
    int now;
    UILabel *label ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMiss) name:@"dismiss" object:nil];
    
    now = 0;
    if ( [[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)] ) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    // Do any additional setup after loading the view.
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [back setImage:[self createImageByName:@"c229loading"]];
    [self.view addSubview:back];
    timer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(goJinDu) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-50, 0, 50, 30)];
    label.text = @"5s";
    [self.view addSubview:label];
    
}
- (void)dealloc{
    [timer invalidate];
}
- (void)goJinDu{
    now = now + 1;
    label.text = [NSString stringWithFormat:@"%ds",5-now];
    if (now>=3) {
        HQ229MainViewController *vc = [[HQ229MainViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
        
        [timer invalidate];
    }
}
- (void)disMiss{
    [self dismissViewControllerAnimated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}

@end
