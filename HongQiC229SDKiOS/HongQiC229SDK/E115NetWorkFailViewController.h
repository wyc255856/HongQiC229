//
//  E115NetWorkFailViewController.h
//  HongQiC229
//
//  Created by 李卓轩 on 2020/6/2.
//  Copyright © 2020 freedomTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface E115NetWorkFailViewController : UIViewController
@property (nonatomic, copy)void(^retry)(NSString *);
@property (nonatomic, copy)void(^back)(NSString *);
- (void)addBtn:(NSInteger)x;
@end

NS_ASSUME_NONNULL_END
