//
//  FirstView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "FirstView.h"
#import "ShanShuoView.h"
#import "AppFaster.h"
#import "C229CAR_Masonry.h"
#import "TagBtn.h"
#import "C229ChooseModelViewController.h"
@implementation FirstView
{
    
    int total;
    CGFloat now;
    CGFloat jianju;
    int change;
    ShanShuoView *ss1;
    ShanShuoView *ss2;
    ShanShuoView *ss3;
    TagBtn *ssBtn1;
    TagBtn *ssBtn2;
    TagBtn *ssBtn3;
    UIImageView *ssImg1;
    UIImageView *ssImg2;
    UIImageView *ssImg3;
    CGFloat carWidth;
    CGFloat carHeight;
    UIScrollView *scroll;
    UIButton *chooseBtn;
    
    
    BOOL hiddenAble;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    
    return self;
    
    
    
}
- (void)setCarID:(NSString *)carID{
    _carID = carID;
    hiddenAble = NO;
    carHeight = 270;
    carWidth = 270*1920/900;
    total = 1;
    now = 736;
    jianju = self.frame.size.width/56;
    
    [self setCarImage];
    [self allocAllLineAndImage];
    [self reSetTagBtn:total];
    [self addScrollView];
    [self setAllLineAndImageFrame:total];
    
    [self allShow];
    
    change = 1;
    
    scroll.showsVerticalScrollIndicator = NO;
    
    chooseBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-91)/2,self.frame.size.height-50, 91, 20)];
    chooseBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:chooseBtn];
    [chooseBtn setImage:[AppManager createImageByName:@"c229chooseBtnImage"] forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(chooseBtnAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)chooseBtnAction{
    if (self) {
        self.jumpChooseModel(nil);
    }
}
- (void)allocAllLineAndImage{
    ss1 = [[ShanShuoView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    ss2 = [[ShanShuoView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    ss3 = [[ShanShuoView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    [self addSubview:ss1];
    [self addSubview:ss2];
    [self addSubview:ss3];
    ssImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    ssImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    ssImg3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:ssImg1];
    [self addSubview:ssImg2];
    [self addSubview:ssImg3];
}
- (void)setCarImage{
    _carImage = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-carWidth)/2, (self.frame.size.height-carHeight)/2, carWidth, carHeight)];
    //[_carImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hq229-%d",total]]];
    if ([self.carID isEqualToString:@"C229"]) {
        [_carImage setImage:[self get360ImageByName:[NSString stringWithFormat:@"c229_car_%d",total]]];
    }else{
        [_carImage setImage:[self get360ImageByName:[NSString stringWithFormat:@"e115_car_%d",total]]];
    }
    
    [self addSubview:_carImage];
    
}
- (void)addOne{
    if (change==0) {
        return;
    }
    if (total == 36) {
        total=1;
    }else{
        total++;
    }
    [self changeImage];
}
- (void)delOne{
    if (change==0) {
        return;
    }
    if (total==1) {
        total = 36;
    }else{
        total--;
    }
    
    [self changeImage];
}
- (void)changeImage{
    
    if ([self.carID isEqualToString:@"C229"]) {
        [_carImage setImage:[self get360ImageByName:[NSString stringWithFormat:@"c229_car_%d",total]]];
    }else{
        [_carImage setImage:[self get360ImageByName:[NSString stringWithFormat:@"e115_car_%d",total]]];
    }
}
- (void)addScrollView{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scroll.contentSize = CGSizeMake(self.frame.size.width*3, self.frame.size.height);
    scroll.delegate = self;
    [scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
    scroll.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroll];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.x);
    if (hiddenAble) {
        CGFloat offY = scrollView.contentOffset.x;
        if (offY-now>=jianju) {
            [self addOne];
            now = offY;
        }else if(offY-now<=-jianju){
            [self delOne];
            now = offY;
        }
        [self allHide];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    now = 736;
    [self setAllLineAndImageFrame:total];
    [self allShow];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    change = 0;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    change = 1;
    hiddenAble = YES;
    
}

- (void)allShow{
    ss1.hidden = NO;
    ss2.hidden = NO;
    ss3.hidden = NO;
    ssBtn1.hidden = NO;
    ssBtn2.hidden = NO;
    ssBtn3.hidden = NO;
    ssImg1.hidden = NO;
    ssImg2.hidden = NO;
    ssImg3.hidden = NO;
    [chooseBtn removeFromSuperview];
    [self addSubview:chooseBtn];
}
- (void)allHide{
    ss1.hidden = YES;
    ss2.hidden = YES;
    ss3.hidden = YES;
    ssBtn1.hidden = YES;
    ssBtn2.hidden = YES;
    ssBtn3.hidden = YES;
    ssImg1.hidden = YES;
    ssImg2.hidden = YES;
    ssImg3.hidden = YES;
}

- (void)goJump:(TagBtn *)btn{
    
    NSString *newName = [NSString stringWithFormat:@"%@_news",_carID];
        NSDictionary *all = [self readLocalFileWithName:newName];
        NSArray *array = [all objectForKey:@"RECORDS"];
    NSString *itemID;
    if ([_carID isEqualToString:@"C229"]) {
        if ([btn.myTitle isEqualToString:@"轮胎/车轮"]) {
            itemID = @"169";
        }else if ([btn.myTitle isEqualToString:@"发动机舱"]){
            itemID = @"168";
        }else if ([btn.myTitle isEqualToString:@"外后视镜"]){
            itemID = @"127";
        }else if ([btn.myTitle isEqualToString:@"刮水器"]){
            itemID = @"219";
        }else if ([btn.myTitle isEqualToString:@"天窗"]){
            itemID = @"117";
        }else if ([btn.myTitle isEqualToString:@"前照灯"]){
            itemID = @"129";
        }else if ([btn.myTitle isEqualToString:@"油箱盖"]){
            itemID = @"131";
        }else if ([btn.myTitle isEqualToString:@"行李箱盖"]){
            itemID = @"113";
        }else if ([btn.myTitle isEqualToString:@"车门"]){
            itemID = @"112";
        }
    }else if ([_carID isEqualToString:@"E115"]){
        if ([btn.myTitle isEqualToString:@"轮胎/车轮"]) {
            itemID = @"180";
        }else if ([btn.myTitle isEqualToString:@"机舱"]){
            itemID = @"183";
        }else if ([btn.myTitle isEqualToString:@"外后视镜"]){
            itemID = @"81";
        }else if ([btn.myTitle isEqualToString:@"刮水器"]){
            itemID = @"175";
        }else if ([btn.myTitle isEqualToString:@"天窗"]){
            itemID = @"27";
        }else if ([btn.myTitle isEqualToString:@"前照灯"]){
            itemID = @"177";
        }else if ([btn.myTitle isEqualToString:@"充电口"]){
            itemID = @"181";
        }else if ([btn.myTitle isEqualToString:@"行李箱盖"]){
            itemID = @"28";
        }else if ([btn.myTitle isEqualToString:@"车门"]){
            itemID = @"190";
        }
    }
        
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    for (NSDictionary *d in array) {
        NSString *tid = [NSString stringWithFormat:@"%@",d[@"id"]];
        if ([itemID isEqualToString:tid]) {
            if (self) {
                self.jumpToDetail(d);
            }
        }
    }

}
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    
    // 获取文件路径
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileDir = [docDir stringByAppendingPathComponent:@""];
    NSString *filePath = [fileDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",name]];
    NSString *path = [resourceBundle pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    // 对数据进行JSON格式化并返回字典形式
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!error) {
        return dic;
    }else{
        return nil;
    }
}
- (void)reSetTagBtn:(int)x{
    switch (x) {
        
        
        case 1:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn1 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"发动机舱"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn1 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"机舱"];
            }
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-dengguang" AndTitle:@"前照灯"];
            break;
        case 2:
        case 3:
        case 4:
        case 5:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"229-360-icon/229-360-tianchuang" AndTitle:@"天窗"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-tianchuang" AndTitle:@"天窗"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-yushua" AndTitle:@"刮水器"];
            break;
        case 10:
        case 11:
        ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        [ssBtn1 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
        ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        [ssBtn2 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"天窗"];
        ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        [ssBtn3 setImage:@"229-360-icon/229-360-chelun" AndTitle:@"轮胎/车轮"];
        break;
        case 6:
        case 7:
        case 8:
        case 9:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"车门"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-chelun" AndTitle:@"轮胎/车轮"];
            break;
        case 12:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-houbeixiang" AndTitle:@"行李箱盖"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-chelun" AndTitle:@"轮胎/车轮"];
            break;
        case 13:
        case 14:
        case 15:
        case 16:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"行李箱盖"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-houbeixiang" AndTitle:@"外后视镜"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"车门"];
            break;
        
        case 17:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"车门"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-houbeixiang" AndTitle:@"行李箱盖"];
            break;
        case 18:
        case 19:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"油箱盖"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"充电口"];
            }
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-chelun" AndTitle:@"轮胎/车轮"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-houbeixiang" AndTitle:@"行李箱盖"];
            break;
        case 20:
        case 21:
        case 22:
        case 23:
        case 24:
        case 25:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"油箱盖"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"充电口"];
            }
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"车门"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-houbeixiang" AndTitle:@"行李箱盖"];
            break;
        case 26:
        case 27:
        case 28:
        case 29:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"油箱盖"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn1 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"充电口"];
            }
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn2 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"发动机舱"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn2 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"机舱"];
            }
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-chelun" AndTitle:@"轮胎/车轮"];
            break;
        case 30:
        case 31:
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-tianchuang" AndTitle:@"天窗"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn3 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"油箱盖"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn3 setImage:@"229-360-icon/229-360-youxianggai" AndTitle:@"充电口"];
            }
                
            break;
        case 32:
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-tianchuang" AndTitle:@"天窗"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-chemen" AndTitle:@"车门"];
            break;
        case 33:
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-tianchuang" AndTitle:@"天窗"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"229-360-icon/229-360-yushua" AndTitle:@"刮水器"];
            break;
        case 34:
        case 35:
        case 36:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            
            if ([_carID isEqualToString:@"C229"]) {
                [ssBtn1 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"发动机舱"];
            }else if ([_carID isEqualToString:@"E115"]){
                [ssBtn1 setImage:@"229-360-icon/229-360-jicang" AndTitle:@"机舱"];
            }
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"229-360-icon/229-360-houshijing" AndTitle:@"外后视镜"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            
            [ssBtn3 setImage:@"229-360-icon/229-360-dengguang" AndTitle:@"前照灯"];
            break;
        
        default:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"houbeixiang.png" AndTitle:@"1"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"dengguang.png" AndTitle:@"2"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"chelun.png" AndTitle:@"3"];
            break;
    }
    [self addSubview:ssBtn1];
    [self addSubview:ssBtn2];
    [self addSubview:ssBtn3];
    [ssBtn1 addTarget:self action:@selector(goJump:) forControlEvents:UIControlEventTouchUpInside];
    [ssBtn2 addTarget:self action:@selector(goJump:) forControlEvents:UIControlEventTouchUpInside];
    [ssBtn3 addTarget:self action:@selector(goJump:) forControlEvents:UIControlEventTouchUpInside];
}
- (UIImage *)get360ImageByName:(NSString *)name{
    NSString *localKey = [NSString stringWithFormat:@"%@localResource",_carID];
    NSString *imageFile = [[NSUserDefaults standardUserDefaults] objectForKey:localKey];
    NSString *fileAdd;
    if ([_carID isEqualToString:@"C229"]) {
        fileAdd = [NSString stringWithFormat:@"%@/c229-36images",imageFile];
    }else if([_carID isEqualToString:@"E115"]){
        fileAdd = [NSString stringWithFormat:@"%@/e115-36images",imageFile];
    }
    NSString *theImageFile = [NSString stringWithFormat:@"%@/%@",fileAdd,name];
    UIImage *image = [UIImage imageWithContentsOfFile:theImageFile];
    
    return image;
}
-(UIImage *) createImageByName:(NSString*)sName{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    NSString *resName = sName;
    UIImage *image =  resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
    return image;
}
- (void)setAllLineAndImageFrame:(int)x{
    NSLog(@"%d",x);
    [_carImage removeFromSuperview];
    _carImage = nil;
    [scroll removeFromSuperview];
    scroll = nil;
    [ss1 removeFromSuperview];
    ss1 = nil;
    [ss2 removeFromSuperview];
    ss2 = nil;
    [ss3 removeFromSuperview];
    ss3 = nil;
    [ssBtn1 removeFromSuperview];
    ssBtn1 = nil;
    [ssBtn2 removeFromSuperview];
    ssBtn2 = nil;
    [ssBtn3 removeFromSuperview];
    ssBtn3 = nil;
    [ssImg1 removeFromSuperview];
    ssImg1 = nil;
    [ssImg2 removeFromSuperview];
    ssImg2 = nil;
    [ssImg3 removeFromSuperview];
    ssImg3 = nil;
    [self setCarImage];
    [self allocAllLineAndImage];
    [self addScrollView];
    [self reSetTagBtn:x];
    if ([_carID isEqualToString:@"C229"]) {
        switch (x) {
            case 1:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+150, _carImage.frame.origin.y+125, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-245, _carImage.frame.origin.y+120, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+128, _carImage.frame.origin.y+140, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-4/229line-4-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-4/229line-4-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-5);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 2:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250, _carImage.frame.origin.y+88, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+118, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 3:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-245, _carImage.frame.origin.y+88, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+115, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 4:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250, _carImage.frame.origin.y+88, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+205, _carImage.frame.origin.y+115, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 5:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250, _carImage.frame.origin.y+88, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+208, _carImage.frame.origin.y+115, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/600));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+27);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 6:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+230, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-190, _carImage.frame.origin.y+143, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 7:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+230, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-200, _carImage.frame.origin.y+133, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 8:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+218, _carImage.frame.origin.y+120, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-210, _carImage.frame.origin.y+133, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 9:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+212, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-225, _carImage.frame.origin.y+133, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 10:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+202, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-235, _carImage.frame.origin.y+123, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 11:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-255, _carImage.frame.origin.y+123, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 12:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-175, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 13:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-175, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+188, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 14:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-175, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+198, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 15:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+202, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-205, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+215, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 16:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+207, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-238, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+215, _carImage.frame.origin.y+170, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

               
                break;
            }
            case 17:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+360, _carImage.frame.origin.y+120, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-220, _carImage.frame.origin.y+157, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 18:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+315, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-190, _carImage.frame.origin.y+157, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+180, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 19:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+285, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+157, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+160, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 20:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+247, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+5);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 21:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+223, _carImage.frame.origin.y+127, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 22:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+195, _carImage.frame.origin.y+127, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 23:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+174, _carImage.frame.origin.y+127, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 24:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+168, _carImage.frame.origin.y+127, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 25:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+158, _carImage.frame.origin.y+127, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-210, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 26:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+147, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 27:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+147, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 28:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+147, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 29:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+147, _carImage.frame.origin.y+130, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 30:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+93, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+167, _carImage.frame.origin.y+130, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 31:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+93, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+177, _carImage.frame.origin.y+130, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 32:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+90, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+210, _carImage.frame.origin.y+130, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 33:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-255, _carImage.frame.origin.y+90, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+247, _carImage.frame.origin.y+118, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 34:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+215, _carImage.frame.origin.y+128, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250+40, _carImage.frame.origin.y+117, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+210, _carImage.frame.origin.y+142, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1.png"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(210, 210*153/574));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-1/229line-1-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/538));
                    make.left.equalTo(ss2.c229_mas_right).offset(+1);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-1);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-1/229line-1-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*115/555));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+2);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 35:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+120+5, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260+40, _carImage.frame.origin.y+115, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+186, _carImage.frame.origin.y+140, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-2/229line-2-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*153/516));
                    make.right.equalTo(ss1.c229_mas_right).offset(-7);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-2/229line-2-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/556));
                    make.left.equalTo(ss2.c229_mas_left).offset(+6);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(220, 115*220/486));
                    make.right.equalTo(ss3.c229_mas_right).offset(-8);
                    make.top.equalTo(ss3.c229_mas_top).offset(+3);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 36:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+194-30, _carImage.frame.origin.y+118+8, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-270+40, _carImage.frame.origin.y+116, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+155-10, _carImage.frame.origin.y+140, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-3/229line-3-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/475));
                    make.right.equalTo(ss1.c229_mas_right).offset(-4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-3);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-3/229line-3-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*93/583));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-1);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-3/229line-3-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(165, 165*115/414));
                    make.right.equalTo(ss3.c229_mas_right).offset(-8);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+95);
                    make.top.equalTo(ssImg2.c229_mas_top).offset(-5);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+38);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            
            
                break;
        }
    }else if ([_carID isEqualToString:@"E115"]){
        switch (x) {
            case 1:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+145, _carImage.frame.origin.y+115, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-245, _carImage.frame.origin.y+110, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+118, _carImage.frame.origin.y+143, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-4/229line-4-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-5);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+105);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 2:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250, _carImage.frame.origin.y+72, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+110, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 3:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-245, _carImage.frame.origin.y+70, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+103, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 4:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-245, _carImage.frame.origin.y+70, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+108, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 5:{
                [ss1 removeFromSuperview];
                    [ssImg1 removeFromSuperview];
                    [ssBtn1 removeFromSuperview];
                    
                    ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-235, _carImage.frame.origin.y+70, 4, 4);
                    
                    ss3.frame = CGRectMake(_carImage.frame.origin.x+204, _carImage.frame.origin.y+103, 4, 4);
                    [ssImg1 setImage:[self createImageByName:@"229line-4/229line-4-img1"]];
                    
                    
                    [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                        make.left.equalTo(ss2.c229_mas_left).offset(+8);
                        make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                    }];
                    
                    [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/600));
                        make.right.equalTo(ss3.c229_mas_right).offset(-10);
                        make.top.equalTo(ss3.c229_mas_top).offset(+1);
                    }];

                    

                    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg2.c229_mas_left).offset(+130);
                        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];

                    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                        make.left.equalTo(ssImg3.c229_mas_left).offset(+27);
                        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                    }];
                    
                    break;
                
            }
            case 6:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+220, _carImage.frame.origin.y+108, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-193, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 7:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+217, _carImage.frame.origin.y+106, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-200, _carImage.frame.origin.y+115, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 8:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+210, _carImage.frame.origin.y+107, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-215, _carImage.frame.origin.y+123, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 9:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+103, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-240, _carImage.frame.origin.y+127, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 10:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+107, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-235, _carImage.frame.origin.y+72, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 11:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+107, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-255, _carImage.frame.origin.y+74, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+120);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 12:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+109, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-175, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+158, _carImage.frame.origin.y+170, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 13:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+107, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-175, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+162, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 14:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+110, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+207, _carImage.frame.origin.y+165, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 15:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+205, _carImage.frame.origin.y+113, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-220, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+207, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 16:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+212, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-218, _carImage.frame.origin.y+107, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+215, _carImage.frame.origin.y+170, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

               
                break;
            }
            case 17:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+360, _carImage.frame.origin.y+105, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-215, _carImage.frame.origin.y+146, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+200, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 18:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+315, _carImage.frame.origin.y+120, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-190, _carImage.frame.origin.y+152, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+180, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 19:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+295, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+150, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+160, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/445));
                    make.left.equalTo(ss1.c229_mas_right).offset(+4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.right.equalTo(ssImg1.c229_mas_right).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 20:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+253, _carImage.frame.origin.y+126, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+153, _carImage.frame.origin.y+150, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+5);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 21:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+223, _carImage.frame.origin.y+121, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img3"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 22:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+195, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 23:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+178, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-195, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 24:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+170, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-215, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+133, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 25:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+158, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-210, _carImage.frame.origin.y+147, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+126, _carImage.frame.origin.y+150, 4, 4);
                [ss3 removeFromSuperview];
                [ssBtn3 removeFromSuperview];
                [ssImg1 setImage:[self createImageByName:@"229line-23/229line-23-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*153/720));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-24/c229-24-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(240, 240*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
               
                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+150);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];


                break;
            }
            case 26:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+152, _carImage.frame.origin.y+120, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+107, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 27:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+148, _carImage.frame.origin.y+122, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+108, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 28:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+147, _carImage.frame.origin.y+117, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+108, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 29:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+152, _carImage.frame.origin.y+118, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-180, _carImage.frame.origin.y+108, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+175, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*153/445));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-9/229line-9-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/617));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.bottom.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-8/229line-8-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(160, 160*115/382));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+15);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+115);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(-10);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 30:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+73, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+163, _carImage.frame.origin.y+120, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 31:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+73, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+177, _carImage.frame.origin.y+120, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 32:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260, _carImage.frame.origin.y+70, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+210, _carImage.frame.origin.y+130, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-33/229line-33-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*120/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.bottom.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+15);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 33:{
                
                [ss1 removeFromSuperview];
                [ssImg1 removeFromSuperview];
                [ssBtn1 removeFromSuperview];
                
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-255, _carImage.frame.origin.y+70, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+253, _carImage.frame.origin.y+113, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-5/229line-5-img1"]];
                
                
                [ssImg2 setImage:[self createImageByName:@"229line-5/229line-5-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*93/690));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-5/229line-5-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*80/576));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+133);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                
                break;
            }
            case 34:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+213, _carImage.frame.origin.y+117, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-250+40, _carImage.frame.origin.y+108, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+210, _carImage.frame.origin.y+128, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-1/229line-1-img1.png"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(210, 210*153/574));
                    make.right.equalTo(ss1.c229_mas_right).offset(-6);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-1/229line-1-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/538));
                    make.left.equalTo(ss2.c229_mas_right).offset(+1);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-1);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-1/229line-1-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*115/555));
                    make.right.equalTo(ss3.c229_mas_right).offset(-10);
                    make.top.equalTo(ss3.c229_mas_top).offset(+2);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+100);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 35:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+197, _carImage.frame.origin.y+120, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-260+40, _carImage.frame.origin.y+105, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+186, _carImage.frame.origin.y+132, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-2/229line-2-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(230, 230*153/516));
                    make.right.equalTo(ss1.c229_mas_right).offset(-7);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-2);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-2/229line-2-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(200, 200*93/556));
                    make.left.equalTo(ss2.c229_mas_left).offset(+6);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-3);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-2/229line-2-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(220, 115*220/486));
                    make.right.equalTo(ss3.c229_mas_right).offset(-8);
                    make.top.equalTo(ss3.c229_mas_top).offset(+3);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+90);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+25);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+30);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+43);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            case 36:{
                ss1.frame = CGRectMake(_carImage.frame.origin.x+194-25, _carImage.frame.origin.y+118+2, 4, 4);
                ss2.frame = CGRectMake(_carImage.frame.origin.x+_carImage.frame.size.width-270+40, _carImage.frame.origin.y+104, 4, 4);
                
                ss3.frame = CGRectMake(_carImage.frame.origin.x+155, _carImage.frame.origin.y+127, 4, 4);
                [ssImg1 setImage:[self createImageByName:@"229line-3/229line-3-img1"]];
                [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(180, 180*153/475));
                    make.right.equalTo(ss1.c229_mas_right).offset(-4);
                    make.bottom.equalTo(ss1.c229_mas_bottom).offset(-3);

                }];
                
                [ssImg2 setImage:[self createImageByName:@"229line-3/229line-3-img2"]];
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(190, 190*93/583));
                    make.left.equalTo(ss2.c229_mas_left).offset(+8);
                    make.top.equalTo(ss2.c229_mas_bottom).offset(-1);
                }];
                
                [ssImg3 setImage:[self createImageByName:@"229line-3/229line-3-img3"]];
                [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(165, 165*115/414));
                    make.right.equalTo(ss3.c229_mas_right).offset(-8);
                    make.top.equalTo(ss3.c229_mas_top).offset(+1);
                }];

                [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                    make.bottom.equalTo(ssImg1.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+95);
                    make.top.equalTo(ssImg2.c229_mas_top).offset(-5);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];

                [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg3.c229_mas_left).offset(+25);
                    make.bottom.equalTo(ssImg3.c229_mas_top).offset(+38);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
                break;
            }
            
            
                break;
        }
    }

}
@end
