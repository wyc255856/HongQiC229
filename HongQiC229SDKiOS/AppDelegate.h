//
//  AppDelegate.h
//  HongQiH5SDKiOS
//
//  Created by Yu Chen on 2018/7/11.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setNewOrientation:(BOOL)fullscreen;

/** 是否允许转向 */
@property (nonatomic, assign) BOOL allowRotation;

@end

