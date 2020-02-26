//
//  SecondTableViewCell.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/17.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)loadWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
