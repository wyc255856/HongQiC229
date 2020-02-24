//
//  ForthCollectionViewCell.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/16.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ForthCollectionViewCell.h"

@implementation ForthCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.layer.cornerRadius = 8;
}
- (void)loadWithDataDic:(NSDictionary *)dic andTag:(NSIndexPath *)index{
    _tittleLabel.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"localResource"];
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,dic[@"image1"]];
    UIImage *image = [UIImage imageWithContentsOfFile:file];
    if (!image) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",str,dic[@"image2"]]];
    }
    [self.image setImage:image];
}
@end
