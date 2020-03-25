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

    }

    


    [[self shareIndstance].requestSerializer setValue:authorization forHTTPHeaderField:@"token"];
    [[self shareIndstance].requestSerializer setValue:authorization forHTTPHeaderField:@"uid"];

    [[self shareIndstance] GET:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isShow) {

        }
        
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShow) {

        }
        

        enError(error);
    }];

}
+ (void)requestPOSTWithURLStr:(NSString *)urlStr WithAuthorization:(NSString *)authorization paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError andShowLoading:(Boolean)isShow{

    if (isShow) {

    }
    NSString *imei = [[UIDevice currentDevice]identifierForVendor].UUIDString;
    
    [self shareIndstance].requestSerializer =  [C229CAR_AFHTTPRequestSerializer serializer];
    [self shareIndstance].responseSerializer = [C229CAR_AFJSONResponseSerializer serializer];
    
    //请求头
    [[self shareIndstance].requestSerializer setValue:@"ios" forHTTPHeaderField:@"new_device_type"];
    [[self shareIndstance].requestSerializer setValue:imei forHTTPHeaderField:@"deviceId"];

   
  
    
    [[self shareIndstance] POST:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isShow) {

        }
        if (![[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"0"]) {
            if ([urlStr isEqualToString:@"post/updateVersion"]||[urlStr isEqualToString:@"post/getAppIsReview"]) {
                return;
            }
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] isEqualToString:@"3"]) {

                return ;
            }
            return;
        }
    
        finish(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isShow) {

        }
        enError(error);

    }];
}



@end
