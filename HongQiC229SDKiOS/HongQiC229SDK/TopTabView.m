//
//  TopTabView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "TopTabView.h"
#import "AppFaster.h"
@implementation TopTabView
{
    CGFloat btnWidth;
    NSArray *titleArr;
    UIView *selected;
}
- (id)initWithFrame:(CGRect)frame{
    btnWidth = frame.size.width/5;
    titleArr = @[@"车型概览",@"快速入门",@"车型亮点",@"手册",@"搜索"];
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)setUI{
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, self.frame.size.height)];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor colorWithRed:131/255.0 green:135/255.0 blue:142/255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self addSubview:button];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 0)];
    line.backgroundColor = [UIColor colorWithRed:26/255.0 green:27/255.0 blue:28/255.0 alpha:1];
    [self addSubview:line];
    
}
- (void)btnClick:(UIButton *)btn{
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
    }
    btn.selected = !btn.selected;
    selected.frame = CGRectMake(0, self.frame.size.height-3, btn.titleLabel.text.length*15, 3);
    [selected setCenter:CGPointMake(btn.center.x, 50)];
    if (self) {
        self.seleced(btn.tag-1000);
    }
}
- (void)reset{
    for (UIButton *btn in self.subviews) {
        if (btn.tag == 1000) {
            btn.selected = YES;
            selected = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-3, btn.titleLabel.text.length*15, 3)];
            selected.backgroundColor = [AppManager colorWithHexString:@"83baff"];
            selected.layer.cornerRadius = 1;
            [self addSubview:selected];
            [selected setCenter:CGPointMake(btn.center.x, 50)];
        }
    }
}
@end
