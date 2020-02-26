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
    NSString *imageStr = [NSString stringWithFormat:@"%@",dic[@"image1"]];
    imageStr = [imageStr stringByReplacingOccurrencesOfString:@"../" withString:@""];
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,imageStr];
    UIImage *image = [UIImage imageWithContentsOfFile:file];
    UIImage *imagex = [UIImage imageWithData:[NSData dataWithContentsOfFile:file] scale:1];
//    if (!image) {
//        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",str,dic[@"image2"]]];
//    }
    [self.image setImage:imagex];
}
@end
