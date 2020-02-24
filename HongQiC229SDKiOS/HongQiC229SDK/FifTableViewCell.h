//
//  FifTableViewCell.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FifTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)loadWithData:(NSDictionary *)dic andStr:(NSString *)keyWords;
@end

NS_ASSUME_NONNULL_END
