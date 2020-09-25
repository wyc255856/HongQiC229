//
//  C229LoadingViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2020/2/20.
//  Copyright © 2020 Parry. All rights reserved.
//

#import "ElectronicManualViewController.h"
#import "AppFaster.h"
#import "HQ229MainViewController.h"
#import "NetWorkManager.h"
#import "C229NetWorkFailViewController.h"
#import "DownLoadViewViewController.h"
@interface ElectronicManualViewController ()

@end

@implementation ElectronicManualViewController
{
    NSMutableDictionary *zipSucDic;
    NSMutableArray *fileNameArr;
    NSString *newVersion;
    NSDictionary *updateResponse;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
        return UIInterfaceOrientationLandscapeLeft;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
#pragma clang diagnostic ignored "-Wmismatched-return-types"
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#pragma clang diagnostic pop
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(BOOL)shouldAutorotate {
    return NO;
}
- (void)dealloc{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [back setImage:[self createImageByName:@"c229loading"]];
    [self.view addSubview:back];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    zipSucDic = [NSMutableDictionary dictionary];
    [zipSucDic setValue:@"0" forKey:@"category"];
    [zipSucDic setValue:@"0" forKey:@"news"];
    fileNameArr = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMiss) name:@"dismiss" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpMain) name:@"unziped" object:nil];
    //创建临时路径
    NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        NSString *temPath = [NSString stringWithFormat:@"temZip"];
        NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
    if (![self isExistsAtPath:folderPath]) {
        [self createDirectoryAtPath:folderPath error:nil];
    }
    
    [self initNetWork];
    
    
}
- (void)getZipAdd{
    
    DownLoadViewViewController *downLoad = [[DownLoadViewViewController alloc] init];
    downLoad.myDic = updateResponse;
    [self presentViewController:downLoad animated:NO completion:nil];
    
}
- (void)initNetWork{
    NSString *oldUrl = [NSString stringWithFormat:@"hongqih9_admin/index.php?m=home&c=index&a=get_car_info&car_name="];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",oldUrl,_carID];
    
    [NetWorkManager requestGETSuperAPIWithURLStr:urlStr WithAuthorization:@"" paramDic:nil finish:^(id  _Nonnull responseObject) {
        updateResponse = responseObject;
        
        [self downLoadJson];
       
    
    } enError:^(NSError * _Nonnull error) {
        C229NetWorkFailViewController *fail =[[C229NetWorkFailViewController alloc] init];
        [fail addBtn:2];
        fail.retry = ^(NSString *str) {
            [self initNetWork];
        };
        fail.back = ^(NSString * str) {
            [self disMiss];
        };
        [self presentViewController:fail animated:NO completion:nil];
    } andShowLoading:NO];
}

- (void)downLoadJson{
    NSString *catUrl = [NSString stringWithFormat:@"%@",updateResponse[@"category_url"]];
//    catUrl = [catUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *downloadURL2 = [NSURL URLWithString:catUrl];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:downloadURL2];
    NSURLSessionDownloadTask *downloadTask2 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request2 progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"download progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@_category.json",_carID];
        //返回文件的最终存储路径
        NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        //    NSString *folderPath = [allPath stringByAppendingPathComponent:@"c229App/images/ppp"];
            NSString *temPath = [NSString stringWithFormat:@"temZip"];
            NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
            NSString *last = [folderPath stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:last];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@_category.json",_carID];
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *oldPath = [documentsDirectory stringByAppendingPathComponent:fileName];

        NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        NSString *temPath = [NSString stringWithFormat:@"temZip"];
        NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
        NSString *last = [folderPath stringByAppendingPathComponent:fileName];



        if (error) {
            NSLog(@"download2 file failed : %@", [error description]);

        }else {
            NSLog(@"download2 file success");

            NSError *error;
            [self moveItemAtPath:last toPath:oldPath overwrite:YES error:&error];
            [self->zipSucDic setValue:@"1" forKey:@"category"];
            [self isDownloadJson];
        }
    }];

    [downloadTask2 resume];
    //news

    
    NSString *newUrl = [NSString stringWithFormat:@"%@",updateResponse[@"news_url"]];
//    newUrl = [newUrl stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *downloadURL3 = [NSURL URLWithString:newUrl];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:downloadURL3];
    NSURLSessionDownloadTask *downloadTask3 = [[C229CAR_AFHTTPSessionManager manager]downloadTaskWithRequest:request3 progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"download3 progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@_news.json",_carID];
        //返回文件的最终存储路径
        NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        //    NSString *folderPath = [allPath stringByAppendingPathComponent:@"c229App/images/ppp"];
            NSString *temPath = [NSString stringWithFormat:@"temZip"];
            NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
            NSString *last = [folderPath stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:last];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download3 file failed : %@", [error description]);
        
        }else {
            NSLog(@"download3 file success");
            
            NSString *fileName = [NSString stringWithFormat:@"%@_news.json",_carID];
            //返回文件的最终存储路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *oldPath = [documentsDirectory stringByAppendingPathComponent:fileName];
            NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];

                NSString *temPath = [NSString stringWithFormat:@"temZip"];
                NSString *folderPath = [allPath stringByAppendingPathComponent:temPath];
                NSString *last = [folderPath stringByAppendingPathComponent:fileName];
            NSError *error;
            [self moveItemAtPath:last toPath:oldPath overwrite:YES error:&error];
            [zipSucDic setValue:@"1" forKey:@"news"];
            [self isDownloadJson];
        }
    }];
    

    [downloadTask3 resume];
}

- (void)jumpMain{
    HQ229MainViewController *vc = [[HQ229MainViewController alloc] init];
    vc.dataDic = updateResponse;
    
    [self presentViewController:vc animated:NO completion:nil];
}
- (void)disMiss{
    
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"C229NotificationPortrait" object:nil];

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
        //parry
        
        NSString *nowVersion = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@Version",_carID]];
        NSString *newVersion = [updateResponse objectForKey:@"version"];
        if ([nowVersion isEqualToString:newVersion]) {
            [self jumpMain];
        }else{
            [self getZipAdd];
        }
        
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
//           删掉被移动文件
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
-(void)copyFileFromPath:(NSString *)sourcePath toPath:(NSString *)toPath

{

NSFileManager *fileManager = [[NSFileManager alloc] init];

NSArray* array = [fileManager contentsOfDirectoryAtPath:sourcePath error:nil];

for(int i = 0; i<[array count]; i++)

{

NSString *fullPath = [sourcePath stringByAppendingPathComponent:[array objectAtIndex:i]];

NSString *fullToPath = [toPath stringByAppendingPathComponent:[array objectAtIndex:i]];

NSLog(@"%@",fullPath);

NSLog(@"%@",fullToPath);

//判断是不是文件夹

BOOL isFolder = NO;

//判断是不是存在路径 并且是不是文件夹

BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isFolder];

if (isExist)

{

NSError *err = nil;

[[NSFileManager defaultManager] copyItemAtPath:fullPath toPath:fullToPath error:&err];

NSLog(@"%@",err);

if (isFolder)

{

[self copyFileFromPath:fullPath toPath:fullToPath];

}

}

}

}

@end
