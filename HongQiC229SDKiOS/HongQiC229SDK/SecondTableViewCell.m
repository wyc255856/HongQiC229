//
//  SecondTableViewCell.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/17.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)loadWithDic:(NSDictionary *)dic{
    _titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"catname"]];
}
@end
