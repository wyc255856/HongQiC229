//
//  E115ForthView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2020/6/4.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface E115ForthView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy)void(^push)(NSDictionary *);
@end

NS_ASSUME_NONNULL_END
