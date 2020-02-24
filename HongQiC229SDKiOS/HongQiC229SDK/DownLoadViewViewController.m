//
//  DownLoadViewViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/18.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "DownLoadViewViewController.h"
#import "C229CAR_SSZipArchive.h"
@interface DownLoadViewViewController ()<SSZipArchiveDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation DownLoadViewViewController
{
    
    __weak IBOutlet UIButton *yesBtn;
    __weak IBOutlet UIButton *noBtn;
    float jindu;
    
//test
    NSTimer *timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _myPro.hidden = YES;
    yesBtn.hidden = YES;
    noBtn.hidden = YES;
    
}
- (void)viewDidAppear:(BOOL)animated{

//    [self zipLoad];
    _myPro.progress = 0;
    jindu = 0;
    [self setUI:0];
    timer = [NSTimer timerWithTimeInterval:0.3 target:self selector:@selector(goJinDu) userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
- (void)dealloc{
    [timer invalidate];
}
- (void)downLoad{
    [self setUI:0];
}
- (void)zipLoad{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    NSString *allPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSString *folderPath = [allPath stringByAppendingPathComponent:@"imageP"];
    NSString *zipED = [resourceBundle pathForResource:@"images" ofType:@"zip"];
    
    NSLog(@"%@",folderPath);
   
    [[NSUserDefaults standardUserDefaults] setObject:folderPath forKey:@"localResource"];
     __weak typeof(self) weakSelf = self;
    [C229CAR_SSZipArchive unzipFileAtPath:zipED toDestination:folderPath overwrite:YES password:nil progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {

    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        weakSelf.myPro.progress = 1;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unziped" object:nil];
        [timer invalidate];
        [self dismissViewControllerAnimated:YES completion:nil];
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
- (void)goJinDu{
    jindu = jindu + 0.1;
    if (jindu >= 0.9) {
        [self setUI:1];
        _myPro.progress = 0.95;
        if (jindu>0.95) {
            [timer invalidate];
            
            [self zipLoad];
        }
    }else{
        _myPro.progress = _myPro.progress+0.1;
        
    }
}
@end
