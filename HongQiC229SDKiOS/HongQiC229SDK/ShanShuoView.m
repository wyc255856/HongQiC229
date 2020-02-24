//
//  ShanShuoView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/25.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ShanShuoView.h"

@implementation ShanShuoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    //1
    UIView *bai = [[UIView alloc] initWithFrame:self.bounds];
        bai.layer.cornerRadius = self.frame.size.width/2;
        bai.backgroundColor = [UIColor whiteColor];
        [self addSubview:bai];
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue=[NSNumber numberWithFloat:1.0];
        animation.toValue=[NSNumber numberWithFloat:1.4];
        animation.duration=1;
        animation.autoreverses=NO;
        animation.repeatCount= HUGE_VALF;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        [bai.layer addAnimation:animation forKey:@"zoom"];
        
        
        
        CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];

        anim1.duration = 1;

        anim1.fromValue = (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;

        anim1.toValue = (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5].CGColor;

        anim1.repeatCount = HUGE_VALF;
        anim1.beginTime = 0.0;
        anim1.autoreverses = NO;
        anim1.removedOnCompletion=NO;
        anim1.fillMode=kCAFillModeForwards;
        [bai.layer addAnimation:anim1 forKey:@"backgroundColor"];
    //2
    UIView *hei = [[UIView alloc] initWithFrame:self.bounds];
    hei.backgroundColor = [UIColor whiteColor];
    CABasicAnimation *anim3 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    hei.layer.cornerRadius = self.frame.size.width/2;
    anim3.duration = 0.3;

    anim3.fromValue = (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5].CGColor;
    
    anim3.toValue = (id)[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;

    anim3.repeatCount = HUGE_VALF;
    anim3.beginTime = 0.0;
    anim3.autoreverses = NO;
    anim3.removedOnCompletion=NO;
    anim3.fillMode=kCAFillModeForwards;
    [hei.layer addAnimation:anim3 forKey:@"backgroundColor"];
    
    CABasicAnimation *animation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation1.fromValue=[NSNumber numberWithFloat:1.4];
    animation1.toValue=[NSNumber numberWithFloat:1.8];
    animation1.duration=1;
    animation1.autoreverses=YES;
    animation1.repeatCount= HUGE_VALF;
    animation1.removedOnCompletion=NO;
    animation1.fillMode=kCAFillModeForwards;
    [hei.layer addAnimation:animation1 forKey:@"zoom"];
    [self addSubview:hei];
    //3
    UIView *other = [[UIView alloc] initWithFrame:self.bounds];
    other.backgroundColor = [UIColor whiteColor];
    other.layer.cornerRadius = self.frame.size.width/2;
    [self addSubview:other];
    
    return self;
}

@end
