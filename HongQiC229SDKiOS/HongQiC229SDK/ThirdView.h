//
//  ThirdView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdView : UIView<UIWebViewDelegate>
@property(nonatomic,  copy)void(^jumpToDetail)(NSDictionary *);
@end

NS_ASSUME_NONNULL_END
