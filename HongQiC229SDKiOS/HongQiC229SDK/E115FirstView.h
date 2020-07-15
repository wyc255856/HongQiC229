//
//  E115FirstView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2020/7/15.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface E115FirstView : UIView<UIScrollViewDelegate>
@property (nonatomic, copy)void(^jumpToDetail)(NSDictionary *);
@property (nonatomic, copy)void(^jumpChooseModel)(NSDictionary *);
@property (nonatomic, strong)UIImageView *carImage;
- (void)allShow;
@end

NS_ASSUME_NONNULL_END
