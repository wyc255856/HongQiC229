//
//  ForthView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForthView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy)void(^push)(NSDictionary *);
@property (nonatomic, strong)NSString *carID;
@end

NS_ASSUME_NONNULL_END
