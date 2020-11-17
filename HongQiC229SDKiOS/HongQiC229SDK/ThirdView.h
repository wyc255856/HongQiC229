//
//  ThirdView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ThirdView : UIView<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,  copy)void(^jumpToDetail)(NSDictionary *);
@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
