//
//  C229ChooseModelViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/4/28.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import "C229ChooseModelViewController.h"
#import "AppFaster.h"
//Zdhh 3.0商务 5
//zdss 3.0高 4
//sdhh 2.0中配 2
//sdss  2.0入门  1
//sdzg 2.0高 3
@interface C229ChooseModelViewController ()

@end

@implementation C229ChooseModelViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [backImage setImage:[AppManager createImageByName:@"c229chooseModelBack.jpg"]];
    [self.view addSubview:backImage];
    
    
}
- (void)setSettingArr:(NSArray *)settingArr{
    _settingArr = settingArr;
    [self createBtn];
}
- (void)createBtn{
//    UIView *back = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-282)/2, (kScreenHeight-34*5)/2, 282, 34*5)];
    
    UIScrollView *backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake((kScreenWidth-282)/2, (kScreenHeight-34*5)/2, 282, 34*5)];
    
    
//    NSArray *rightArr = @[@"2.0低配",@"2.0中配",@"2.0高配",@"3.0高配",@"3.0商务"];
    [self.view addSubview:backScroll];
    
    backScroll.contentSize = CGSizeMake ((kScreenWidth-282)/2, _settingArr.count*34);
    
    for (int i=1; i<_settingArr.count+1; i++) {
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*34-1,  backScroll.frame.size.width, 1)];
        [backScroll addSubview:lineImg];
        [lineImg setImage:[AppManager createImageByName:@"c229chooseline"]];    
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, i*34-28, 100, 20)];
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.text = @"2020款";
        [backScroll addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, i*34-28, 100, 20)];
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = [UIColor whiteColor];
        rightLabel.text = [_settingArr[i-1] objectForKey:@"content_desc"];
        [backScroll addSubview:rightLabel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, i*34-34, backScroll.frame.size.width, 34)];
        [backScroll addSubview:button];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
- (void)buttonClick:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *strID = [NSString stringWithFormat:@"%@",[_settingArr[btn.tag-1000-1] objectForKey:@"content_id"]];
    
    NSString *sst = [NSString stringWithFormat:@"%@ModelChoose",_carID];
    [user setObject:strID forKey:sst];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"c229chooseModel" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
