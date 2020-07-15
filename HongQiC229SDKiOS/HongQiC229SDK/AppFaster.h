//
//  AppFaster.h
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#ifndef AppFaster_h
#define AppFaster_h

#define kScreenWidth               ([UIScreen mainScreen].bounds.size.width)
/*
 iphoneX 底部虚拟home键高度 非安全区
 */
#define KIphoneXBottomOffset            (34)

/*
 1.若为iphoneX 机型 获取安全区域高度  计算方法为 812 - 34
 2.若为普通机型正常取值
 */
#define kScreenHeight                   ([UIScreen mainScreen].bounds.size.height>=812.0f?[UIScreen mainScreen].bounds.size.height-KIphoneXBottomOffset:[UIScreen mainScreen].bounds.size.height)
#import "AppManager.h"
//判断iponex
#define IsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//ihone8
#define IsiPhone8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//iphoneMax
#define IsiPhone8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define C229HttpServer @"http://www.haoweisys.com"
//#define C229HttpServer @"http://www.e-guides.faw.cn"
#endif /* AppFaster_h */
