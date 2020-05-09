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
    [self createBtn];
    
}

- (void)createBtn{
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-282)/2, (kScreenHeight-34*5)/2, 282, 34*5)];
    NSArray *rightArr = @[@"2.0低配",@"2.0中配",@"2.0高配",@"3.0高配",@"3.0商务"];
    [self.view addSubview:back];
    for (int i=1; i<6; i++) {
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*34-1,  back.frame.size.width, 1)];
        [back addSubview:lineImg];
        [lineImg setImage:[AppManager createImageByName:@"c229chooseline"]];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, i*34-28, 50, 20)];
        leftLabel.font = [UIFont systemFontOfSize:14];
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.text = @"2020款";
        [back addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, i*34-28, 50, 20)];
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = [UIColor whiteColor];
        rightLabel.text = rightArr[i-1];
        [back addSubview:rightLabel];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, i*34-34, back.frame.size.width, 34)];
        [back addSubview:button];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
- (void)buttonClick:(UIButton *)btn{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    switch (btn.tag) {
        case 1001:
            [user setObject:@"sdss" forKey:@"c229ModelChoose"];
            break;
        case 1002:
            [user setObject:@"sdhh" forKey:@"c229ModelChoose"];
            break;
        case 1003:
            [user setObject:@"sdzg" forKey:@"c229ModelChoose"];
            break;
        case 1004:
            [user setObject:@"zdss" forKey:@"c229ModelChoose"];
            break;
        case 1005:
            [user setObject:@"zdhh" forKey:@"c229ModelChoose"];
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"c229chooseModel" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
