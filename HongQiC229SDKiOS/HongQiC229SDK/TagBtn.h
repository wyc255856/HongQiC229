//
//  TagBtn.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/27.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagBtn : UIButton
@property (nonatomic, strong)NSString *myTitle;
- (void)setImage:(NSString *)name AndTitle:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
