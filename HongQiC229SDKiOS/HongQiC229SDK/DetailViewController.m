//
//  DetailViewController.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/19.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "DetailViewController.h"
#import "AppFaster.h"
#import "CLPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "ShanShuoView.h"
@interface DetailViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
@property (nonatomic, strong)id myTimeObserve;
@property (nonatomic, strong)UIProgressView *myPro;
@property (nonatomic, strong)UILabel *left;
@property (nonatomic, strong)UILabel *right;
@property (nonatomic, strong)UIButton *startBtn;
@property (nonatomic, strong)UIView *reStartView;
@end

@implementation DetailViewController
{
    NSArray *dataArr;
    UIView *backView;
    UIScrollView *myScroll;
    CGFloat scrollHEIGHT;
    UIPageControl *pageControl;
    NSDictionary *allDic;
    int nowDeadLine;
    int restartIsShow;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollHEIGHT = kScreenHeight-40-140;
    nowDeadLine = 10;
    restartIsShow = 0;
}
/*
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
        return UIInterfaceOrientationLandscapeRight;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
#pragma clang diagnostic ignored "-Wmismatched-return-types"
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#pragma clang diagnostic pop
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate {
    return NO;
}
 */
- (void)setDataDic:(NSDictionary *)dataDic{
    [self setback];
    NSMutableArray *temArr = [NSMutableArray array];
    for (int i = 1; i<11; i++) {
        NSString *key = [NSString stringWithFormat:@"template%d",i];
        NSString *value = [NSString stringWithFormat:@"%@",dataDic[key]];
        if ([value isEqualToString:@"-1"]) {
            break;
        }
        [temArr addObject:value];
    }
    
    dataArr = temArr;
    allDic = dataDic;
    [self setUi];

    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 19, 21, 19)];
    [closeBtn setImage:[self createImageByName:@"neirongguanbianniu"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:closeBtn];
    
}
- (void)setback{
    self.view.backgroundColor = [UIColor clearColor];
    backView = [[UIView alloc] initWithFrame:CGRectMake(25, 20, kScreenWidth-50, kScreenHeight-40)];
    backView.backgroundColor = [UIColor clearColor];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [backImage setImage:[self createImageByName:@"neirongyebeijingtu1"]];
    [self.view addSubview:backImage];
    [self.view addSubview:backView];
}
- (void)closeAction{
    [self.myPlayer pause];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setUi{
//    if (dataArr.count>1) {
//        [self setMore];
//    }else{
//        backView.hidden = YES;
//        [self addVideo];
//    }
    NSString *str = [dataArr objectAtIndex:0];
    if ([str isEqualToString:@"6"]) {
        [self addVideo];
    }else{
        [self setMore];
    }
}
- (void)setMore{
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, backView.frame.size.width, scrollHEIGHT)];
    myScroll.delegate = self;
    myScroll.showsHorizontalScrollIndicator = NO;
    myScroll.contentSize = CGSizeMake(backView.frame.size.width*dataArr.count, scrollHEIGHT);
    myScroll.pagingEnabled = YES;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((backView.frame.size.width-100)/2, backView.frame.size.height - 50, 100, 30)];
    pageControl.backgroundColor = [UIColor clearColor];
    [pageControl setCurrentPage:0];
    pageControl.numberOfPages = dataArr.count;
    [backView addSubview:myScroll];
    [backView addSubview:pageControl];
    for (int i = 1; i<=dataArr.count; i++) {
        NSString *type = dataArr[i-1];
        if ([type isEqualToString:@"0"]) {
            [self addTuWen:i];
        }else if ([type isEqualToString:@"1"]){
            [self addWenBen:i];
        }else if ([type isEqualToString:@"3"]){
            [self addTuPian:i];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pageControl.currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
}
- (void)addTuWen:(int)index{
    UIView *bk = [[UIView alloc] initWithFrame:CGRectMake((index-1)*myScroll.frame.size.width, 0, myScroll.frame.size.width, myScroll.frame.size.height)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(31, 0, scrollHEIGHT, scrollHEIGHT)];
    image.backgroundColor = [UIColor clearColor];
    NSString *key = [NSString stringWithFormat:@"image%d",index];
    NSString *iPath = [NSString stringWithFormat:@"%@",allDic[key]];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"localResource"];
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,iPath];
    file = [file stringByReplacingOccurrencesOfString:@"HONGQIH9/standard/" withString:@""];
    [image setImage:[UIImage imageWithContentsOfFile:file]];
    [bk addSubview:image];
    
    NSString *cKey = [NSString stringWithFormat:@"content%d",index];
    NSString *contentStr = [NSString stringWithFormat:@"%@",allDic[cKey]];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(31+scrollHEIGHT+20, 0, myScroll.frame.size.width-31-scrollHEIGHT-20-20, scrollHEIGHT)];
    [web loadHTMLString:contentStr baseURL:nil];
    web.backgroundColor = [UIColor clearColor];
    web.opaque = NO; //不设置这个值 页面背景始终是白色
    web.delegate = self;
    [bk addSubview:web];
    
    [myScroll addSubview:bk];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //字体大小
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '330%'"];
    //字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'white'"];
    //页面背景色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='rgba(113,255,255,0)'"];
}
- (void)addWenBen:(int)xx{
    UIView *bk = [[UIView alloc]initWithFrame:CGRectMake(myScroll.frame.size.width*(xx-1), 0, myScroll.frame.size.width, myScroll.frame.size.height)];
    [myScroll addSubview:bk];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(30, 0, myScroll.frame.size.width-30-30, scrollHEIGHT)];
    NSString *cKey = [NSString stringWithFormat:@"content%d",xx];
    NSString *contentStr = [NSString stringWithFormat:@"%@",allDic[cKey]];
    [web loadHTMLString:contentStr baseURL:nil];
    web.backgroundColor = [UIColor clearColor];
    web.opaque = NO; //不设置这个值 页面背景始终是白色
    web.delegate = self;
    [bk addSubview:web];
}
- (void)addTuPian:(int)xx{
    UIView *bk = [[UIView alloc]initWithFrame:CGRectMake((xx-1)*myScroll.frame.size.width, 0, myScroll.frame.size.width, myScroll.frame.size.height)];
    
    
    NSString *key = [NSString stringWithFormat:@"image%d",xx];
    NSString *iPath = [NSString stringWithFormat:@"%@",allDic[key]];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"localResource"];
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,iPath];
    file = [file stringByReplacingOccurrencesOfString:@"HONGQIH9/standard/" withString:@""];
    UIImage *theImage = [UIImage imageWithContentsOfFile:file];
    
    if (!theImage) {
        return;
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, myScroll.frame.size.width-62, (myScroll.frame.size.width-62)*theImage.size.height/theImage.size.width)];
    
    image.backgroundColor = [UIColor clearColor];
    UIScrollView *imageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(31, 0, myScroll.frame.size.width-62, myScroll.frame.size.height)];
    [image setImage:theImage];
    imageScroll.contentSize = image.frame.size;
    [imageScroll addSubview:image];
    [bk addSubview:imageScroll];
    [myScroll addSubview:bk];
}
- (void)addVideo{
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, backView.frame.size.width, scrollHEIGHT)];
    [backView addSubview:myScroll];
    
    
    pageControl.hidden = YES;

    NSString *iPath = @"images/2019-03-12/5c870f97c6e23.mp4";
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"localResource"];
    NSString *file = [NSString stringWithFormat:@"%@/%@",str,iPath];
    file = [file stringByReplacingOccurrencesOfString:@"HONGQIH9/standard/" withString:@""];
    NSURL *url = [NSURL fileURLWithPath:file];

    self.item = [AVPlayerItem playerItemWithURL:url];
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view.layer addSublayer:self.playerLayer];
    
    _myPro = [[UIProgressView alloc] initWithFrame:CGRectMake(30, kScreenHeight-50, kScreenWidth-60, 20)];
    [self.view addSubview:_myPro];
    _left = [[UILabel alloc] initWithFrame:CGRectMake(30, kScreenHeight-20-15, 100, 15)];
    _left.font = [UIFont systemFontOfSize:15];
    _left.textColor = [UIColor whiteColor];
    
    _right = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-100-30, kScreenHeight-20-15, 100, 15)];
    _right.font = [UIFont systemFontOfSize:15];
    
    _right.textColor = [UIColor whiteColor];
    _right.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_right];
    [self.view addSubview:_left];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 19, 21, 19)];
    [closeBtn setImage:[self createImageByName:@"neirongguanbianniu"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    __weak __typeof(self) weakSelf = self;
    _myTimeObserve = [self.myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 60) queue:NULL usingBlock:^(CMTime time) {

            NSInteger proMin                    = (NSInteger)CMTimeGetSeconds(time) / 60;//当前秒
            NSInteger proSec                    = (NSInteger)CMTimeGetSeconds(time) % 60;//当前分钟
        
            NSInteger proMinx               = (NSInteger)CMTimeGetSeconds(weakSelf.item.duration) / 60;//当前秒
            NSInteger proSecx                    = (NSInteger)CMTimeGetSeconds(weakSelf.item.duration) % 60;//当前分钟
            weakSelf.left.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)proMin, (long)proSec];
            weakSelf.right.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)proMinx, (long)proSecx];
        
            weakSelf.myPro.progress = CMTimeGetSeconds(time)/CMTimeGetSeconds(self.item.duration);
        if ((NSInteger)CMTimeGetSeconds(time)==self->nowDeadLine) {
            if (self->restartIsShow==0) {
                [weakSelf.view addSubview:weakSelf.reStartView];
                self->restartIsShow = 1;
            }
            [weakSelf.myPlayer pause];
            
        }
        }];
    
     
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [self.myPlayer play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
//                self.isReadToPlay = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                _left.text = @"0:00";
                NSInteger proMin                    = CMTimeGetSeconds(self.item.duration) / 60;//当前秒
                NSInteger proSec                    = (int)CMTimeGetSeconds(self.item.duration) % 60;//当前分钟
                _right.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)proMin, (long)proSec];
                [self.view addSubview:self.startBtn];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
//                self.isReadToPlay = NO;
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}
- (UIButton *)startBtn{
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-55)/2, (kScreenHeight-55)/2, 55, 55)];
    [_startBtn setImage:[self createImageByName:@"starPlayBtnImage"] forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(StartPlayer) forControlEvents:UIControlEventTouchUpInside];
    return _startBtn;
}
- (void)StartPlayer{
    [self.myPlayer play];
    [_startBtn removeFromSuperview];
}
- (UIView *)reStartView{
    _reStartView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth-290)/2, (kScreenHeight-145)/2, 290, 145)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:_reStartView.bounds];
    [img setImage:[self createImageByName:@"restarone"]];
    [_reStartView addSubview:img];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(_reStartView.frame.size.width-34, _reStartView.frame.size.height-30, 29, 25)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_reStartView addSubview:button];
    [button setImage:[self createImageByName:@"chongxinbofang"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reStart) forControlEvents:UIControlEventTouchUpInside];
    ShanShuoView *ss = [[ShanShuoView alloc] initWithFrame:CGRectMake((290-15)/2, 65, 15, 15)];
    
    [_reStartView addSubview:ss];
    UIButton *jxbfBtn = [[UIButton alloc] initWithFrame:CGRectMake((290-30)/2, 115/2, 30, 30)];
    [_reStartView addSubview:jxbfBtn];
    [jxbfBtn addTarget:self action:@selector(jixubofang) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jixubofang)];
    [ss addGestureRecognizer:tap];
    return _reStartView;
}
- (void)reStart{
    CMTime time = CMTimeMake(0, 1);
    [self.myPlayer seekToTime:time];
    [self.myPlayer play];
    [_reStartView removeFromSuperview];
    restartIsShow = 0;
}
- (void)jixubofang{
    nowDeadLine = nowDeadLine+10;
    [self.myPlayer play];
    [_reStartView removeFromSuperview];
    restartIsShow = 0;
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
