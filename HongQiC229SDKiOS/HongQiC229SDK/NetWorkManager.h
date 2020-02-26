//
//  NetWorkManager.h
//  family_doctor
//
//  Created by wangzeming on 2019/3/6.
//  Copyright © 2019 Parry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C229CAR_AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN
@interface NetWorkManager : C229CAR_AFHTTPSessionManager

+ (NetWorkManager *)shareIndstance;
+ (void)requestGETSuperAPIWithURLStr:(NSString *)urlStr WithAuthorization:(NSString *)authorization paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError andShowLoading:(Boolean *)isShow;
+ (void)requestPOSTWithURLStr:(NSString *)urlStr WithAuthorization:(NSString *)authorization paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError andShowLoading:(Boolean)isShow;

@end
NS_ASSUME_NONNULL_END
