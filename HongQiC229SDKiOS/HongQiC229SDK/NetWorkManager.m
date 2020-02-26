//
//  NetWorkManager.m
//  family_doctor
//
//  Created by wangzeming on 2019/3/6.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "NetWorkManager.h"
#define HTTP_SERVER @"https://www.haoweisys.com/"
@implementation NetWorkManager
+(NetWorkManager *)shareIndstance{
    static NetWorkManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:HTTP_SERVER];
        manager = [[NetWorkManager alloc] initWithBaseURL:url];
        manager.requestSerializer = [[C229CAR_AFJSONRequestSerializer alloc] init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"charset=UTF-8", nil];;
        
    });
    
    return manager;
}
+ (void)requestGETSuperAPIWithURLStr:(NSString *)urlStr WithAuthorization:(NSString *)authorization paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError andShowLoading:(Boolean *)isShow{
    if (isShow) {
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    }
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"charset=UTF-8", nil];
    


    [[self shareIndstance].requestSerializer setValue:authorization forHTTPHeaderField:@"token"];
    [[self shareIndstance].requestSerializer setValue:authorization forHTTPHeaderField:@"uid"];
//    NSDictionary *headerDic = @{
//                                authorization:@"Authorization",
//                                @"application/json":@"Accept"
//                                };
    [[self shareIndstance] GET:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isShow) {
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        }
        
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShow) {
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        }
        
//        [SVProgressHUD showErrorWithStatus:error.description];
        enError(error);
    }];
//    [[self shareIndstance] GET:urlStr parameters:paramDic headers:headerDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 成功回调
//        finish(responseObject);
//        // 如果superapikey过期，重新保存加密获取新的
//        // 如果用户apikey过期，则重新登录
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 失败回调
//        enError(error);
//    }];
    //    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        // 成功回调
    //        finish(responseObject);
    //        // 如果superapikey过期，重新保存加密获取新的
    //        // 如果用户apikey过期，则重新登录
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        // 失败回调
    //        enError(error);
    //
    //    }];
}
+ (void)requestPOSTWithURLStr:(NSString *)urlStr WithAuthorization:(NSString *)authorization paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError andShowLoading:(Boolean)isShow{

    if (isShow) {
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    }
    NSString *imei = [[UIDevice currentDevice]identifierForVendor].UUIDString;
    
    [self shareIndstance].requestSerializer =  [C229CAR_AFHTTPRequestSerializer serializer];
    [self shareIndstance].responseSerializer = [C229CAR_AFJSONResponseSerializer serializer];
    
    //请求头
    [[self shareIndstance].requestSerializer setValue:@"ios" forHTTPHeaderField:@"new_device_type"];
    [[self shareIndstance].requestSerializer setValue:imei forHTTPHeaderField:@"deviceId"];

   
  
    
    [[self shareIndstance] POST:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isShow) {
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        }
        if (![[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"0"]) {
            if ([urlStr isEqualToString:@"post/updateVersion"]||[urlStr isEqualToString:@"post/getAppIsReview"]) {
                return;
            }
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"3"]) {
//                [SVProgressHUD showErrorWithStatus:@"您的账号在其他设备登录,请重新登录"];
                return ;
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"maintabbarlogout" object:nil];
            }
//            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            
            return;
            
        }
        
        
        
        finish(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShow) {
//            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
        }
        enError(error);
//        [SVProgressHUD showErrorWithStatus:error.description];
    }];
}

+ (void)getNetStatus:(void(^)(C229CAR_AFNetworkReachabilityStatus status))back{
    [[C229CAR_AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(C229CAR_AFNetworkReachabilityStatus status) {
        back(status);
        [[C229CAR_AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
    [[C229CAR_AFNetworkReachabilityManager sharedManager] startMonitoring];
    
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                NSLog(@"未知网络");
//                break;
//
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                NSLog(@"没有网络(断网)");
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
//                NSLog(@"手机自带网络");
//                break;
//
//            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
//                NSLog(@"WIFI");
//                break;
//        }
    
}

@end
