//
//  FifTableViewCell.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "FifTableViewCell.h"

@implementation FifTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)loadWithData:(NSDictionary *)dic andStr:(NSString *)keyWords{
    NSString *title = [NSString stringWithFormat:@"%@",dic[@"title"]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange range = [title rangeOfString:keyWords];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:131.0f/255.0f green:186.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:range];
    [_titleLabel setAttributedText:attributedString];
}
@end
