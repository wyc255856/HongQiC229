//
//  DownLoadViewViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "DownLoadViewViewController.h"
#import "AppFaster.h"
#import "C229CAR_Masonry.h"
#import "C229CAR_AFNetworking.h"
@interface DownLoadViewViewController ()<SSZipArchiveDelegate>

@property (strong, nonatomic)NSURLSessionDownloadTask *downloadTask3;
@end

@implementation DownLoadViewViewController
{
    
    float jindu;
    NSString *zipLocal;
    NSMutableDictionary *downLoad;
    
    NSData *resumeData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _myPro.hidden = YES;
    downLoad = [NSMutableDictionary dictionary];
    _YESBtn.hidden = YES;
    _NoBtn.hidden = YES;
    _reTry.hidden = YES;
    [self initUI];
    [self downLoad];
}

- (void)initUI{
    CGFloat height = kScreenHeight-60;
    CGFloat width = height*208/121;
   
    //back
    self.backView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-width)/2, 30, width, height)];
    self.backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backView];
    self.backImage = [[UIImageView alloc] initWithFrame:self.backView.bounds];
    [self.backImage setImage:[self createImageByName:@"downLoadBackGround.png"]];
    [self.backView addSubview:self.backImage];
    //title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height-72-112, width, 23)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.titleLabel];
    //progress
    self.myPro = [[UIProgressView alloc] initWithFrame:CGRectMake(114, height-110-2, width-228, 2)];
    [self.backView addSubview:self.myPro];
    
    //yes
    _YESBtn = [[UIButton alloc] initWithFrame:CGRectMake((width-78)/2-69, height-72-112+23+50, 69, 30)];
    [_YESBtn setBackgroundImage:[self createImageByName:@"Btn_N1"] forState:UIControlStateNormal];
    [_YESBtn setTitle:@"是" forState:UIControlStateNormal];
    [_YESBtn addTarget:self action:@selector(yesBtnAcTion) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_YESBtn];
    //no
    _NoBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/2+39, height-72-112+23+50, 69, 30)];
    [_NoBtn setBackgroundImage:[self createImageByName:@"Btn_S1"] forState:UIControlStateNormal];
    [_NoBtn setTitle:@"否" forState:UIControlStateNormal];
    [_NoBtn addTarget:self action:@selector(noBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_NoBtn];
    //retry
    _reTry = [[UIButton alloc] initWithFrame:CGRectMake((width-69)/2, height-72-112+23+50, 69, 30)];
    [_reTry setBackgroundImage:[self createImageByName:@"Btn_S1"] forState:UIControlStateNormal];
    [_reTry setTitle:@"重试" forState:UIControlStateNormal];
    [_reTry addTarget:self action:@selector(reTryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_reTry];
    
}
- (void)reTryAction{
    [_downloadTask3 resume];
    [self downLoad];
}
- (void)yesBtnAcTion{
    [self setUI:0];
    if (resumeData) {
        [self goOnDownLoad];
    }else{
        [self.downloadTask3 suspend];
        [self createDownLoad3];
        [self.downloadTask3 resume];
    }
}
- (void)goOnDownLoad{
    NSURLSessionDownloadTask *downloadTaskGoOn = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"download progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.myPro.progress = 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount ;
            });
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *fileName = @"229image.zip";
            //返回文件的最终存储路径
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
            self->zipLocal = filePath;
            return [NSURL fileURLWithPath:filePath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (error) {
                NSLog(@"download3 file failed : %@", [error description]);
                self->resumeData = [error.userInfo objectForKey:@"NSURLSessionDownloadTaskResumeData"];
                NSLog(@"%@",self->resumeData);
            }else {
                NSLog(@"download3 file success");
                NSLog(@"%@",filePath);
                NSString *zipPath = [NSString stringWithFormat:@"%@",filePath];
                zipPath = [zipPath stringByReplacingOccurrencesOfString:@"file://" withString:@"path://"];
                [self zipLoad:[NSString stringWithFormat:@"%@",zipPath]];
            }
        }];
    [downloadTaskGoOn resume];
    
}
- (void)noBtnAction{
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];
    }];
}
- (void)viewDidAppear:(BOOL)animated{

//    [self zipLoad];
    _myPro.progress = 0;
    jindu = 0;
    
}

- (void)downLoad{
    [self setUI:0];
    NSString *js1 = [NSString stringWithFormat:@"%@",_myDic[@"category"]];
    js1 = [js1 stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSString *js2 = [NSString stringWithFormat:@"%@",_myDic[@"news"]];
    js2 = [js2 stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    

    //js1
    NSURL *downloadURL1 = [NSURL URLWithString:js1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:downloadURL1];
    NSURLSessionDownloadTask *downloadTask1 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request1 progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = @"229_category.json";
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download1 file failed : %@", [error description]);
            [self->_downloadTask3 suspend];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI:2];
            });
        }else {
            NSLog(@"download1 file success");
            [self->downLoad setValue:@"1" forKey:@"js1"];
            if ([self isDownloaded]) {
                [self downLoadOK];
            }
        }
    }];
  
    [downloadTask1 resume];
    //js2
    NSURL *downloadURL2 = [NSURL URLWithString:js2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:downloadURL2];

    NSURLSessionDownloadTask *downloadTask2 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request2 progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = @"229_news.json";
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download2 file failed : %@", [error description]);
            [self->_downloadTask3 suspend];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI:2];
            });
        }else {
            NSLog(@"download2 file success");
            [self->downLoad setValue:@"1" forKey:@"js2"];
            if ([self isDownloaded]) {
                [self downLoadOK];
            }
        }
    }];

    [downloadTask2 resume];
    
    [self createDownLoad3];
//    [downloadTask3 resume];
    C229CAR_AFNetworkReachabilityManager *manager = [C229CAR_AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(C229CAR_AFNetworkReachabilityStatus status) {
        switch (status) {
            case C229CAR_AFNetworkReachabilityStatusUnknown:
            {
                //未知网络
                NSLog(@"未知网络");
            }
                break;
            case C229CAR_AFNetworkReachabilityStatusNotReachable:
            {
                //无法联网
                NSLog(@"无法联网");
                [self setUI:2];
            }
                break;

            case C229CAR_AFNetworkReachabilityStatusReachableViaWWAN:
            {
                //手机自带网络
                NSLog(@"当前使用的是2g/3g/4g网络");
                if (self.downloadTask3) {
                    [self.downloadTask3 suspend];
                }
                [self setUI:4];
            }
                break;
            case C229CAR_AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //WIFI
                NSLog(@"当前在WIFI网络下");
                [self setUI:0];
                if (self->resumeData) {
                    [self goOnDownLoad];
                }else{
                    [self.downloadTask3 resume];
                }
                
            }
                
        }
    }];
}


- (void)zipLoad:(NSString *)path{
    [self setUI:1];
    NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *folderPath = [allPath stringByAppendingPathComponent:@"c229App"];
    path = [path substringFromIndex:7];
   
    [[NSUserDefaults standardUserDefaults] setObject:folderPath forKey:@"localResource"];
     
    [C229CAR_SSZipArchive unzipFileAtPath:path toDestination:folderPath overwrite:YES password:nil progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {

    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"%@",error.description);
        if (error) {
            self->_titleLabel.text = @"解压缩失败";
            [self downLoadOK];
        }
        if (!error) {
            NSLog(@"zipSuc");
            [self->downLoad setValue:@"1" forKey:@"zip"];
            if ([self isDownloaded]) {
                [self downLoadOK];
            }
        }
    }];

}

- (void)setUI:(int)x{
    _YESBtn.hidden = YES;
    _NoBtn.hidden = YES;
    _myPro.hidden = NO;
    _reTry.hidden = YES;
    switch (x) {
        case 0:  //下载中
            self.titleLabel.text = @"正在下载资源包，请勿退出";
            break;
        case 1:  //解压中
        self.titleLabel.text = @"正在解压，请勿退出";
            break;
        case 2:  //断网
        self.titleLabel.text = @"当前网络断开，请检查网络...";
            _myPro.hidden = YES;
            _reTry.hidden =NO;
            break;
        case 3:  //验证资源
        self.titleLabel.text = @"正在验证资源文件完整性";
            break;
        case 4:  //非wifi
        self.titleLabel.text = @"当前非wifi网络是否继续下载";
            _YESBtn.hidden = NO;
            _NoBtn.hidden = NO;
            _myPro.hidden = YES;
            break;
        default:
            break;
    }
}
- (BOOL)isDownloaded{
    if ([downLoad[@"js1"] isEqualToString:@"1"]
        &&[downLoad[@"js2"] isEqualToString:@"1"]
        &&[downLoad[@"zip"] isEqualToString:@"1"] ) {
        NSString *version = [NSString stringWithFormat:@"%@",_myDic[@"version"]];
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"c229NowVersion"];
        return YES;
    }else{
        return NO;
    }
}
- (void)downLoadOK{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unziped" object:nil];
    }];
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}
- (void)createDownLoad3{
    //zip
    NSString *zip = [NSString stringWithFormat:@"%@",_myDic[@"zip_address"]];
    zip = [zip stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *downloadURL3 = [NSURL URLWithString:zip];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:downloadURL3];
    self.downloadTask3 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request3 progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"download progress : %.2f%%", 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myPro.progress = 1.0f * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount ;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fileName = @"229image.zip";
        //返回文件的最终存储路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        self->zipLocal = filePath;
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"download3 file failed : %@", [error description]);
            self->resumeData = [error.userInfo objectForKey:@"NSURLSessionDownloadTaskResumeData"];
            NSLog(@"%@",self->resumeData);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setUI:2];
            });
        }else {
            NSLog(@"download3 file success");
            NSLog(@"%@",filePath);
            NSString *zipPath = [NSString stringWithFormat:@"%@",filePath];
            zipPath = [zipPath stringByReplacingOccurrencesOfString:@"file://" withString:@"path://"];
            [self zipLoad:[NSString stringWithFormat:@"%@",zipPath]];
        }
    }];
}
@end

