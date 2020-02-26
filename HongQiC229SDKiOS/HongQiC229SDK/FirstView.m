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
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    carHeight = 270;
    carWidth = 270*1920/900;
    total = 4;
    now = 736;
    jianju = self.frame.size.width/56;
    [self setCarImage];
    [self allocAllLineAndImage];
    [self reSetTagBtn:total];
    [self addScrollView];
    [self setAllLineAndImageFrame:total];
    
    [self allShow];
    change = 1;
    return self;
    
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
    [_carImage setImage:[self createImageByName:[NSString stringWithFormat:@"c229-36images/hq229-%d",total]]];
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
    NSString *imageName = [NSString stringWithFormat:@"c229-36images/hq229-%d",total];
    [_carImage setImage:[self createImageByName:imageName]];
}
- (void)addScrollView{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    scroll.contentSize = CGSizeMake(self.frame.size.width*3, self.frame.size.height);
    scroll.delegate = self;
    [scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];
    [self addSubview:scroll];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%f",scrollView.contentOffset.x);
    
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
- (void)setAllLineAndImageFrame:(int)x{
    NSLog(@"%d",x);
    [_carImage removeFromSuperview];
    [scroll removeFromSuperview];
    [ss1 removeFromSuperview];
    [ss2 removeFromSuperview];
    [ss3 removeFromSuperview];
    [ssBtn1 removeFromSuperview];
    [ssBtn2 removeFromSuperview];
    [ssBtn3 removeFromSuperview];
    [ssImg1 removeFromSuperview];
    [ssImg2 removeFromSuperview];
    [ssImg3 removeFromSuperview];
    [self setCarImage];
    [self allocAllLineAndImage];
    [self addScrollView];
    [self reSetTagBtn:x];
    switch (x) {
            
        case 1:{
            ss1.frame = CGRectMake(_carImage.frame.origin.x+215, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-200);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-100);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-208);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-135);
            }];
            [ssImg1 setImage:[self createImageByName:@"车灯近.png"]];
            [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*118/314));
                make.right.equalTo(ss1.c229_mas_right);
                make.bottom.equalTo(ss1.c229_mas_bottom);

            }];
            
            [ssImg2 setImage:[self createImageByName:@"后备箱近.png"]];
            [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*107/327));
                make.left.equalTo(ss3.c229_mas_left).offset(+6);
                make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
            }];
            
            [ssImg3 setImage:[self createImageByName:@"无名近.png"]];
            [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*56/314));
                make.left.equalTo(ss2.c229_mas_right).offset(+4);
                make.top.equalTo(ss2.c229_mas_top).offset(+2);
            }];
            
            
            [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                make.bottom.equalTo(ssImg1.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            
            [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg2.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            
            [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg3.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            break;
        }
        case 3:{
            
            ss1.frame = CGRectMake(_carImage.frame.origin.x+145, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-190);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-100);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-185);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-135);
            }];
            
            break;
        }
        case 4:{
            
            ss1.frame = CGRectMake(_carImage.frame.origin.x+130, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-180);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-100);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-170);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-135);
            }];
            
            break;
        }
        case 5:{
            
            ss1.frame = CGRectMake(_carImage.frame.origin.x+110, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-180);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-100);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-150);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-135);
            }];
            
            break;
        }
        case 10:{
            ss1.frame = CGRectMake(_carImage.frame.origin.x+100, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-180);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-80);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-108);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-145);
            }];
            [ssImg1 setImage:[self createImageByName:@"车灯近.png"]];
            [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(150, 150*118/314));
                make.right.equalTo(ss1.c229_mas_right);
                make.bottom.equalTo(ss1.c229_mas_bottom);
            }];
            
            [ssImg2 setImage:[self createImageByName:@"后备箱近.png"]];
            [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(150, 150*107/327));
                make.left.equalTo(ss3.c229_mas_left).offset(+6);
                make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
            }];
            [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg2.c229_mas_left).offset(+70);
                make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            if (IsiPhone8) {
                [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.size.c229_mas_equalTo(CGSizeMake(130, 130*107/327));
                    make.left.equalTo(ss3.c229_mas_left).offset(+6);
                    make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
                }];
                [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                    make.left.equalTo(ssImg2.c229_mas_left).offset(+60);
                    make.bottom.equalTo(ssImg2.c229_mas_top).offset(+20);
                    make.size.c229_mas_equalTo(CGSizeMake(100, 30));
                }];
            }
            
            break;
        }
        case 28:{
            ss1.frame = CGRectMake(_carImage.frame.origin.x+100, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-138);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-70);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-108);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-130);
            }];
            [ssImg1 setImage:[self createImageByName:@"车灯近.png"]];
            [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*118/314));
                make.right.equalTo(ss1.c229_mas_right);
                make.bottom.equalTo(ss1.c229_mas_bottom);
            }];

            [ssImg2 setImage:[self createImageByName:@"后备箱近.png"]];
            [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*107/327));
                make.left.equalTo(ss3.c229_mas_left).offset(+6);
                make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
            }];

            [ssImg3 setImage:[self createImageByName:@"无名近.png"]];
            [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*56/314));
                make.left.equalTo(ss2.c229_mas_right).offset(+4);
                make.top.equalTo(ss2.c229_mas_top).offset(+2);
            }];

            
            [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                make.bottom.equalTo(ssImg1.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];

            [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg2.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];

            [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg3.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            
            break;
        }
        default:{
            
            ss1.frame = CGRectMake(_carImage.frame.origin.x+130, _carImage.frame.origin.y+140, 4, 4);
            [ss2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.right.equalTo(_carImage.c229_mas_right).offset(-180);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-100);
            }];
            [ss3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {make.right.equalTo(_carImage.c229_mas_right).offset(-170);
                make.top.equalTo(_carImage.c229_mas_bottom).offset(-135);
            }];
            [ssImg1 setImage:[self createImageByName:@"车灯近.png"]];
            [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*118/314));
                make.right.equalTo(ss1.c229_mas_right);
                make.bottom.equalTo(ss1.c229_mas_bottom);

            }];
            
            [ssImg2 setImage:[self createImageByName:@"后备箱近.png"]];
            [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*107/327));
                make.left.equalTo(ss3.c229_mas_left).offset(+6);
                make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
            }];
            
            [ssImg3 setImage:[self createImageByName:@"无名近.png"]];
            [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.size.c229_mas_equalTo(CGSizeMake(200, 200*56/314));
                make.left.equalTo(ss2.c229_mas_right).offset(+4);
                make.top.equalTo(ss2.c229_mas_top).offset(+2);
            }];
            
            
            [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
                make.bottom.equalTo(ssImg1.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            
            [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg2.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            
            [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.left.equalTo(ssImg3.c229_mas_left).offset(+110);
                make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
                make.size.c229_mas_equalTo(CGSizeMake(100, 30));
            }];
            break;
        }
            break;
    }
    [ssImg1 setImage:[self createImageByName:@"车灯近.png"]];
    [ssImg1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.size.c229_mas_equalTo(CGSizeMake(200, 200*118/314));
        make.right.equalTo(ss1.c229_mas_right);
        make.bottom.equalTo(ss1.c229_mas_bottom);

    }];
    
    [ssImg2 setImage:[self createImageByName:@"后备箱近.png"]];
    [ssImg2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.size.c229_mas_equalTo(CGSizeMake(200, 200*107/327));
        make.left.equalTo(ss3.c229_mas_left).offset(+6);
        make.bottom.equalTo(ss3.c229_mas_bottom).offset(+4);
    }];
    
    [ssImg3 setImage:[self createImageByName:@"无名近.png"]];
    [ssImg3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.size.c229_mas_equalTo(CGSizeMake(200, 200*56/314));
        make.left.equalTo(ss2.c229_mas_right).offset(+4);
        make.top.equalTo(ss2.c229_mas_top).offset(+2);
    }];
    
    
    [ssBtn1 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.left.equalTo(ssImg1.c229_mas_left).offset(+20);
        make.bottom.equalTo(ssImg1.c229_mas_top).offset(+30);
        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [ssBtn2 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.left.equalTo(ssImg2.c229_mas_left).offset(+110);
        make.bottom.equalTo(ssImg2.c229_mas_top).offset(+30);
        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [ssBtn3 c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
        make.left.equalTo(ssImg3.c229_mas_left).offset(+110);
        make.bottom.equalTo(ssImg3.c229_mas_top).offset(+30);
        make.size.c229_mas_equalTo(CGSizeMake(100, 30));
    }];
}
- (void)goJump{
    
 
        NSDictionary *all = [self readLocalFileWithName:@"zy_news"];
        NSArray *array = [all objectForKey:@"RECORDS"];
    
        for (NSDictionary *d in array) {
            NSString *caid = [NSString stringWithFormat:@"%@",d[@"caid"]];
            if ([caid isEqualToString:@"1896"]) {
                self.jumpToDetail(d);
            }
        }
}
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    // 获取文件路径
    NSString *path = [resourceBundle pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
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
        
        case 28:
            case 1:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"houbeixiang.png" AndTitle:@"后备箱"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"dengguang.png" AndTitle:@"车灯"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"chelun.png" AndTitle:@"车轮/轮毂"];
            break;
        default:
            ssBtn1 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn1 setImage:@"dengguang.png" AndTitle:@"车灯"];
            ssBtn2 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn2 setImage:@"houbeixiang.png" AndTitle:@"后备箱"];
            ssBtn3 = [[TagBtn alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
            [ssBtn3 setImage:@"chelun.png" AndTitle:@"车轮/轮毂"];
            
            break;
    }
    [self addSubview:ssBtn1];
    [self addSubview:ssBtn2];
    [self addSubview:ssBtn3];
    [ssBtn1 addTarget:self action:@selector(goJump) forControlEvents:UIControlEventTouchUpInside];
    [ssBtn2 addTarget:self action:@selector(goJump) forControlEvents:UIControlEventTouchUpInside];
    [ssBtn3 addTarget:self action:@selector(goJump) forControlEvents:UIControlEventTouchUpInside];
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
