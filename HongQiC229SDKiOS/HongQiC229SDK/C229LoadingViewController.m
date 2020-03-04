//
//  C229LoadingViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/2/20.
//  Copyright © 2020 Parry. All rights reserved.
//

#import "C229LoadingViewController.h"
#import "AppFaster.h"
#import "HQ229MainViewController.h"
#import "NetWorkManager.h"
#import "AppDelegate.h"

#import "DownLoadViewViewController.h"
@interface C229LoadingViewController ()

@end

@implementation C229LoadingViewController
{
    NSMutableDictionary *zipSucDic;
    NSMutableArray *fileNameArr;
    NSString *newVersion;
    NSDictionary *updateResponse;
}

//- (BOOL)shouldAutorotate
//
//{
//
//    return NO;
//
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//
//{
//
//    return UIInterfaceOrientationMaskLandscape;
//
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//
//{
//
//    return UIInterfaceOrientationLandscapeLeft;
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//关闭横屏仅允许竖屏
    [appDelegate setNewOrientation:YES];//调用转屏代码
}

- (void)viewDidLoad {
    [super viewDidLoad];
    zipSucDic = [NSMutableDictionary dictionary];
    fileNameArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMiss) name:@"dismiss" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpMain) name:@"unziped" object:nil];
    
    //横屏
    if ( [[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)] ) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeLeft;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
    // Do any additional setup after loading the view.
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [back setImage:[self createImageByName:@"c229loading"]];
    [self.view addSubview:back];
    
    NSUserDefaults *user =  [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"c229NowVersion"]) {
        [NetWorkManager requestGETSuperAPIWithURLStr:@"hongqih9_admin/index.php?m=home&c=index&a=get_first_version" WithAuthorization:@"" paramDic:nil finish:^(id  _Nonnull responseObject) {
            
            DownLoadViewViewController *vc = [[DownLoadViewViewController alloc] init];
            vc.myDic = responseObject;

            [self presentViewController:vc animated:NO completion:nil];

        } enError:^(NSError * _Nonnull error) {
            
        } andShowLoading:YES];
    }else{
        NSString *version = [user objectForKey:@"c229NowVersion"];
        
        NSString *uri = [NSString stringWithFormat:@"hongqih9_admin/index.php?m=home&c=index&a=get_new_info&version_no=%@",version];
        [NetWorkManager requestGETSuperAPIWithURLStr:uri WithAuthorization:@"" paramDic:nil finish:^(id  _Nonnull responseObject) {
           [self jumpMain];
            updateResponse = responseObject;
            if ([version isEqualToString:[NSString stringWithFormat:@"%@",responseObject[@"version"]]]) {
                return ;
            }
            self->newVersion = [NSString stringWithFormat:@"%@",responseObject[@"version"]];
            [self->zipSucDic setValue:@"0" forKey:@"category"];
            [self->zipSucDic setValue:@"0" forKey:@"news"];
            if ([[NSString stringWithFormat:@"%@",responseObject[@"version"]] length]==0) {
                return;
            }
            NSArray *urlArr = responseObject[@"zip_address"];
            for (int x = 0; x<urlArr.count; x++) {
                NSString *longFile = urlArr[x];
                NSString *fileName = [[longFile componentsSeparatedByString:@"/"] lastObject];
                [self->fileNameArr addObject:fileName];
                [self->zipSucDic setValue:@"0" forKey:fileName];
                NSString *zipUrl = [urlArr[x] stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
                
                NSURL *downloadURL1 = [NSURL URLWithString:zipUrl];
                NSURLRequest *request1 = [NSURLRequest requestWithURL:downloadURL1];
                NSURLSessionDownloadTask *downloadTask1 =
                [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request1 progress:^(NSProgress * _Nonnull downloadProgress) {
                    NSLog(@"download progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
                } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                    NSString *fileName = response.suggestedFilename;
                    //返回文件的最终存储路径
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *documentsDirectory = [paths objectAtIndex:0];
                    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
                    
                    return [NSURL fileURLWithPath:filePath];
                } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                    if (error) {
                        NSLog(@"download1 file failed : %@", [error description]);
                    
                    }else {
                        NSString *filePathhStr = [NSString stringWithFormat:@"%@",filePath];
                        NSString *fileName = [[filePathhStr componentsSeparatedByString:@"/"] lastObject];
                        [self zipLoad:[NSString stringWithFormat:@"%@",filePath] and:fileName];
                    }
                }];
               
                [downloadTask1 resume];
            }
            
                } enError:^(NSError * _Nonnull error) {
                    [self jumpMain];
                } andShowLoading:YES];
    }
    
}
- (void)downLoadJson{
    NSString *catUrl = [NSString stringWithFormat:@"%@",updateResponse[@"category"]];
    catUrl = [catUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *downloadURL2 = [NSURL URLWithString:catUrl];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:downloadURL2];
    NSURLSessionDownloadTask *downloadTask2 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request2 progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"download progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = @"229_category.json";
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download2 file failed : %@", [error description]);
        
        }else {
            NSLog(@"download2 file success");
            [self->zipSucDic setValue:@"1" forKey:@"category"];
            [self isDownloadJson];
        }
    }];
    
    [downloadTask2 resume];
    //news

    
    NSString *newUrl = [NSString stringWithFormat:@"%@",updateResponse[@"news"]];
    newUrl = [newUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *downloadURL3 = [NSURL URLWithString:newUrl];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:downloadURL3];
    NSURLSessionDownloadTask *downloadTask3 = [[C229CAR_AFHTTPSessionManager manager]downloadTaskWithRequest:request3 progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = @"229_news.json";
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download1 file failed : %@", [error description]);
        
        }else {
            NSLog(@"download1 file success");
            [zipSucDic setValue:@"1" forKey:@"news"];
            [self isDownloadJson];
        }
    }];
    

    [downloadTask3 resume];
}

- (void)jumpMain{
    HQ229MainViewController *vc = [[HQ229MainViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)disMiss{
    [self dismissViewControllerAnimated:NO completion:^{
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
        [appDelegate setNewOrientation:NO];//调用转屏代码
    }];
}

- (void)zipLoad:(NSString *)filePath and:(NSString *)name{
    
    NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
//    NSString *folderPath = [allPath stringByAppendingPathComponent:@"c229App/images/ppp"];
    NSString *temPath = [NSString stringWithFormat:@"temZip/noBody"];
    NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
    
    NSString *fromFile = [filePath substringFromIndex:7];
    
    
    [C229CAR_SSZipArchive unzipFileAtPath:fromFile toDestination:folderPath overwrite:YES password:nil progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {

    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
            
            NSString *fromStr = [NSString stringWithFormat:@"%@/temZip/HONGQIH9/standard/images",allPath];
            NSString *toSTR = [NSString stringWithFormat:@"%@/c229App/images",allPath];
            NSError *error;
            
            if ([self moveItemAtPath:fromStr toPath:toSTR overwrite:YES error:&error]) {
                [self->zipSucDic setValue:@"1" forKey:fileName];
            }
            [self isDownloaded];
        }
    }];

}
- (BOOL)isDownloadJson{
    BOOL x = YES;
    if ([[zipSucDic objectForKey:@"news"] isEqualToString:@"0"]) {
        x = NO;
    }
    if ([[zipSucDic objectForKey:@"category"] isEqualToString:@"0"]) {
        x = NO;
    }
    if (x) {
        [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"c229NowVersion"];
    }
    return x;
}
- (BOOL)isDownloaded{
    BOOL x = YES;
    for (NSString *name in fileNameArr) {
        NSString *status = [zipSucDic objectForKey:name];
        if ([status isEqualToString:@"0"]) {
            x = NO;
        }
    }
    
    if (x) {
        [self downLoadJson];
        
    }
    return x;
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}
//文件管理
- (BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径" format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [self directoryAtPath:toPath];
    if (![self isExistsAtPath:toDirPath]) {
        // 创建移动路径
        if (![self createDirectoryAtPath:toDirPath error:error]) {
            return NO;
        }
    }
    // 判断目标路径文件是否存在
    if ([self isExistsAtPath:toPath]) {
        //如果覆盖，删除目标路径文件
        if (overwrite) {
            //删掉目标路径文件
            [self removeItemAtPath:toPath error:error];
        }else {
           //删掉被移动文件
            [self removeItemAtPath:path error:error];
            return YES;
        }
    }

    // 移动文件，当要移动到的文件路径文件存在，会移动失败
    BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:path toPath:toPath error:error];

    return isSuccess;
}
- (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}
- (NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error
{
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
     */
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}
- (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}
@end
