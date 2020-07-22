//
//  ForthCollectionViewCell.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/16.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+YYWebImage.h"
NS_ASSUME_NONNULL_BEGIN

@interface ForthCollectionViewCell : UICollectionViewCell
- (void)loadWithDataDic:(NSDictionary *)dic andTag:(NSIndexPath *)index;
@property (weak, nonatomic) IBOutlet UILabel *tittleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, copy) void(^scollTo)(NSIndexPath *);
@end

NS_ASSUME_NONNULL_END
