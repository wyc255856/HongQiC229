//
//  ForthCollectionViewCell.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/16.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ForthCollectionViewCell.h"
#import "AppManager.h"
#import "AppFaster.h"
@implementation ForthCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.layer.cornerRadius = 8;
    [self.image setImage:[AppManager createImageByName:@"c229imagePlace"]];
}
- (void)loadWithDataDic:(NSDictionary *)dic andTag:(NSIndexPath *)index{
    _tittleLabel.text = [NSString stringWithFormat:@"%@",dic[@"title"]];
    NSString *str = C229HttpServer;
    NSString *imageStr = [NSString stringWithFormat:@"%@",dic[@"head_image"]];
  
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,imageStr];

    self.image.backgroundColor = [UIColor lightGrayColor];
    
    [self.image yy_setImageWithURL:[NSURL URLWithString:file] placeholder:[AppManager createImageByName:@"c229imagePlace"]];
     

}
@end
