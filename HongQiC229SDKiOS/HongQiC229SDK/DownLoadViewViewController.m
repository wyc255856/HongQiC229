//
//  DownLoadViewViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "DownLoadViewViewController.h"
#import "AppFaster.h"
#import "C229CAR_AFNetworking.h"
@interface DownLoadViewViewController ()<SSZipArchiveDelegate>
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation DownLoadViewViewController
{
    
    __weak IBOutlet UIButton *yesBtn;
    __weak IBOutlet UIButton *noBtn;
    float jindu;
    NSString *zipLocal;
    NSMutableDictionary *downLoad;
    
//test
    NSTimer *timer;
}
- (BOOL)shouldAutorotate

{

return NO;

}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{

return UIInterfaceOrientationMaskLandscape;

}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{

return UIInterfaceOrientationLandscapeLeft;

}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _myPro.hidden = YES;
    downLoad = [NSMutableDictionary dictionary];
    yesBtn.hidden = YES;
    noBtn.hidden = YES;
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
    //no
    
    
}
- (void)viewDidAppear:(BOOL)animated{

//    [self zipLoad];
    _myPro.progress = 0;
    jindu = 0;
    [self setUI:0];
}

- (void)downLoad{
    [self setUI:0];
    NSString *js1 = [NSString stringWithFormat:@"%@",_myDic[@"category"]];
    js1 = [js1 stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSString *js2 = [NSString stringWithFormat:@"%@",_myDic[@"news"]];
    js2 = [js2 stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSString *zip = [NSString stringWithFormat:@"%@",_myDic[@"zip_address"]];
    zip = [zip stringByReplacingOccurrencesOfString:@"http" withString:@"https"];

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

        }else {
            NSLog(@"download2 file success");
            [self->downLoad setValue:@"1" forKey:@"js2"];
            if ([self isDownloaded]) {
                [self downLoadOK];
            }
        }
    }];

    [downloadTask2 resume];
    //zip
    NSURL *downloadURL3 = [NSURL URLWithString:zip];
    NSURLRequest *request3 = [NSURLRequest requestWithURL:downloadURL3];
    NSURLSessionDownloadTask *downloadTask3 = [[C229CAR_AFHTTPSessionManager manager] downloadTaskWithRequest:request3 progress:^(NSProgress * _Nonnull downloadProgress) {
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
            
        }else {
            NSLog(@"download3 file success");

            [self zipLoad:[NSString stringWithFormat:@"%@",filePath]];
        }
    }];
   
    [downloadTask3 resume];
}


- (void)zipLoad:(NSString *)path{
    [self setUI:1];
    NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *folderPath = [allPath stringByAppendingPathComponent:@"c229App"];
    path = [path substringFromIndex:7];
   
    [[NSUserDefaults standardUserDefaults] setObject:folderPath forKey:@"localResource"];
     
    [C229CAR_SSZipArchive unzipFileAtPath:path toDestination:folderPath overwrite:YES password:nil progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {

    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            
            [self->downLoad setValue:@"1" forKey:@"zip"];
            if ([self isDownloaded]) {
                [self downLoadOK];
            }
        }
    }];

}

- (void)setUI:(int)x{
    yesBtn.hidden = YES;
    noBtn.hidden = YES;
    _myPro.hidden = NO;
    switch (x) {
        case 0:  //下载中
            self.titleLabel.text = @"正在下载资源包，请勿退出";
            break;
        case 1:  //解压中
        self.titleLabel.text = @"正在解压，请勿退出";
            break;
        case 2:  //断网
        self.titleLabel.text = @"当前网络断开，请检查网络...";
            break;
        case 3:  //验证资源
        self.titleLabel.text = @"正在验证资源文件完整性";
            break;
        case 4:  //非wifi
        self.titleLabel.text = @"当前非wifi网络是否继续下载";
            yesBtn.hidden = NO;
            noBtn.hidden = NO;
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unziped" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}

@end

