//
//  FifthView.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXCollectionViewLayout.h"
#import "MXCollectionView.h"
#import "MXCollectionReusableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FifthView : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, MXCollectionViewLayoutDelegate>
@property (nonatomic, strong)UIView *tableHeader;
@property (nonatomic, copy)void(^push)(NSDictionary *);

@property (nonatomic, strong) MXCollectionView *collectionView;
@property (nonatomic, strong) MXCollectionViewLayout *collectionViewLayout;
@property (nonatomic, strong) NSArray <NSString *>*dataArray;
@property (nonatomic, strong) NSArray <NSString *>*sectionArray;
@end

NS_ASSUME_NONNULL_END
  
