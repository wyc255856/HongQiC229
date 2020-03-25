//
//  DownLoadViewViewController.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C229CAR_SSZipArchive.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownLoadViewViewController : UIViewController<SSZipArchiveDelegate>

@property (nonatomic, strong) NSDictionary *myDic;

//ui
@property (nonatomic ,strong) UIView *backView;
@property (nonatomic ,strong) UIImageView *backImage;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIProgressView *myPro;
@property (nonatomic ,strong) UIButton *NoBtn;
@property (nonatomic ,strong) UIButton *YESBtn;
@property (nonatomic ,strong) UIButton *reTry;
@property (nonatomic ,strong) UIButton *cancelBtn;

//
@end

NS_ASSUME_NONNULL_END
