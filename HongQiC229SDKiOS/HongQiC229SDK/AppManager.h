//
//  AppManager.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject
+(UIColor *) colorWithHexString:(NSString *)hexString;
+(CGFloat)getHeightOflabelwithWidth:(CGFloat)Width andString:(NSString *)str andFont:(int)font;
@end

NS_ASSUME_NONNULL_END
