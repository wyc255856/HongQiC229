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

@property (weak, nonatomic) IBOutlet UIProgressView *myPro;

@end

NS_ASSUME_NONNULL_END
