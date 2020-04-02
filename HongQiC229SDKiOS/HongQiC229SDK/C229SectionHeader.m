//
//  C229SectionHeader.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/4/1.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import "C229SectionHeader.h"

@implementation C229SectionHeader

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.frame.size.width-50, 20)];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    
    return self;
}
@end
