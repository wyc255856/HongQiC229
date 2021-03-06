//
//  SecondView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "SecondView.h"
#import "AppFaster.h"
#import "ForthCollectionViewCell.h"
#import "SecondTableViewCell.h"
#import "C229SectionHeader.h"
@implementation SecondView
{
    UIImageView *selImage;
    NSArray *leftArr;
    UICollectionView *myCollection;
    int jianting;
    NSMutableDictionary *allDic;
    UITableView *leftTableView;
    NSMutableArray *cateGGArr;
    UIScrollView *leftScroll;
    NSMutableArray *everyXY;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}
- (void)setCarID:(NSString *)carID{
    _carID = carID;
    [self loadData];
        
        [self setCollectionView];
    //    [self setTableView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNoty) name:@"unziped" object:nil];
        jianting = 1;
        UIImageView *downYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-kScreenWidth*192/1920, kScreenWidth, kScreenWidth*192/1920)];
        
        [downYinYing setImage:[self createImageByName:@"downYinYing"]];
        [self addSubview:downYinYing];
        [self setLeftView];
        UIImageView *upYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*159/1920)];
        [upYinYing setImage:[self createImageByName:@"upYinYing"]];
        [self addSubview:upYinYing];
        [self reSetLeftView:0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"c229chooseModel" object:nil];
}
- (void)getNoty{
    [myCollection reloadData];
}
- (void)loadData{
    NSString *cateStr = [NSString stringWithFormat:@"%@_category",_carID];
    NSDictionary *categoryDic = [self readLocalFileWithName:cateStr];
    NSArray *catArr = categoryDic[@"RECORDS"];
    NSMutableArray *catIdArr = [NSMutableArray array];
    cateGGArr = [NSMutableArray array];
    for (NSDictionary *ds in catArr) {
        if ([self.carID isEqualToString:@"C229"]) {
            if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"1855"]) {
                
                [catIdArr addObject:[NSString stringWithFormat:@"%@",ds[@"catid"]]];
                [cateGGArr addObject:ds];
            }
        }else if ([self.carID isEqualToString:@"E115"]){
            if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"1"]) {
                
                [catIdArr addObject:[NSString stringWithFormat:@"%@",ds[@"catid"]]];
                [cateGGArr addObject:ds];
            }
        }
        
    }
    
    leftArr = catIdArr;
    NSString *newStr = [NSString stringWithFormat:@"%@_news",_carID];
    NSDictionary *newsDic = [self readLocalFileWithName:newStr];
    NSArray *newArr = newsDic[@"RECORDS"];
   
    //
    allDic =[NSMutableDictionary dictionary];
    for (NSString *catID in catIdArr) {
        NSMutableArray *catArr = [NSMutableArray array];
        [allDic setObject:catArr forKey:catID];
    }
    for (NSDictionary *dic in newArr) {
        for (NSString *catID in catIdArr) {
            
            NSString *newId = [NSString stringWithFormat:@"%@",dic[@"catid"]];
            if ([catID isEqualToString:newId]) {
                NSMutableArray *newArr;
                if (![allDic objectForKey:newId]) {
                    newArr = [NSMutableArray array];
                }else{
                    newArr = [allDic objectForKey:newId];
                }
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *chooseStr = [NSString stringWithFormat:@"%@ModelChoose",_carID];
                NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
                if ([model isEqualToString:@"1"]) {
                    [newArr addObject:dic];
                }
                [allDic setObject:newArr forKey:newId];
            }
        }
    }
    [myCollection reloadData];
}
- (void)setLeftView{
    
//    selImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48*12)];
//    [selImage setImage:[self createImageByName:@"secondLeft0"]];
    
    
    leftScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, 128, 300)];
    leftScroll.showsVerticalScrollIndicator = NO;
    leftScroll.contentSize = CGSizeMake(128, 48*cateGGArr.count);
    [self addSubview: leftScroll];
    
//    [leftScroll addSubview: selImage];
    
    for (int i = 0; i < cateGGArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 25+41.4*i, 128-40, 48)];
        NSDictionary *dic = cateGGArr[i];
        [btn setTitle:[NSString stringWithFormat:@"%@",dic[@"catname"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 1000+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:131/255.0 green:186/255.0 blue:255/255.0 alpha:1] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftScroll addSubview:btn];
        [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            if (b.tag == 1000) {
                b.selected = YES;
            }
        }
    }
}
- (void)leftBtnClick:(UIButton *)btn
{
    NSMutableArray *everyGroupCountNum = [NSMutableArray array];
    
    for (NSString *id in leftArr) {
        NSArray *everyArr = [allDic objectForKey:id];
        int count = everyArr.count/4;
        if (everyArr.count%4>0) {
            count = count+1;
        }
        CGFloat they = count *100.00+50;
        NSString *str;
        if (everyGroupCountNum.count>0) {
            str = [NSString stringWithFormat:@"%.2f",they+[[everyGroupCountNum lastObject] floatValue]];
        }else{
            str = [NSString stringWithFormat:@"%.2f",they];
        }
        
        [everyGroupCountNum addObject:str];
    }
    NSString *one = @"0.00";
    [everyGroupCountNum insertObject:one atIndex:0];
    everyXY = everyGroupCountNum;
    
    jianting = 0;
    for (UIButton *b in leftScroll.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = NO;
        }
    }
    NSString *imgName = [NSString stringWithFormat:@"secondLeft%ld",btn.tag-1000];
//    [selImage setImage:[self createImageByName:imgName]];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:btn.tag-1000];
//    [myCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    NSString *yStr = [everyXY objectAtIndex:btn.tag-1000];
    CGFloat yyy = [yStr floatValue];
    [myCollection setContentOffset:CGPointMake(0, yyy) animated:YES];
    [self leftViewScrollTo:btn.tag];
    btn.selected = YES;
    
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
    NSData *jsonData = [[NSFileManager defaultManager] contentsAtPath:filePath];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    // 对数据进行JSON格式化并返回字典形式
    if (!data) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!error) {
        return dic;
    }else{
        return nil;
    }
}
- (void)setCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
//    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(kScreenWidth-50-80-10, 50);
    myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(50+80, 33, kScreenWidth-50-80-10, self.frame.size.height-33-33+40) collectionViewLayout:layout];
    myCollection.backgroundColor = [UIColor clearColor];
    myCollection.delegate = self;
    myCollection.dataSource = self;
    [self addSubview:myCollection];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    [[resourceBundle loadNibNamed:@"ForthCollectionViewCell" owner:self options:nil] lastObject];
     [myCollection registerClass:[C229SectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: @"C229SectionHeader"];
    
    [myCollection registerNib:[UINib nibWithNibName:@"ForthCollectionViewCell" bundle:resourceBundle] forCellWithReuseIdentifier:@"ForthCollectionViewCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    for (int i = 0; i<leftArr.count; i++) {
        if (section == i) {
            NSMutableArray *arr = [allDic objectForKey:leftArr[i]];
//            NSLog(@"----%ld----section:%d",arr.count,section);
            return arr.count;
        }
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return leftArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width-40)/4, 95);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ForthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForthCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic;
    NSMutableArray *newArr = [allDic objectForKey:leftArr[indexPath.section]];
    dic = newArr[indexPath.row];
    [cell loadWithDataDic:dic andTag:indexPath];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [allDic objectForKey:leftArr[indexPath.section]];
    NSDictionary *dic = arr[indexPath.row];
    if (self) {
        self.push(dic);
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGSizeMake(100, 50);
    }else{
        return CGSizeMake(100, 50);
    }
    
}
//footer的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section==11) {
        return CGSizeMake(100, 30);
    }else{
        return CGSizeZero;
    }
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        C229SectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"C229SectionHeader" forIndexPath:indexPath];

        NSDictionary *dic = cateGGArr[indexPath.section];

        headerView.titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"catname"]];
        reusableview = headerView;
    }else{
        C229SectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"C229SectionHeader" forIndexPath:indexPath];

        headerView.titleLabel.text = @"";
        reusableview = headerView;
    }



    return reusableview;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (jianting == 0) {
        return;
    }
    CGFloat ySet = scrollView.contentOffset.y;
    
    NSMutableArray *everyGroupCountNum = [NSMutableArray array];
    
    for (NSString *id in leftArr) {
        NSArray *everyArr = [allDic objectForKey:id];
        int count = everyArr.count/4;
        if (everyArr.count%4>0) {
            count = count+1;
        }
        CGFloat they = count *100.00+50;
        NSString *str;
        if (everyGroupCountNum.count>0) {
            str = [NSString stringWithFormat:@"%.2f",they+[[everyGroupCountNum lastObject] floatValue]];
        }else{
            str = [NSString stringWithFormat:@"%.2f",they];
        }
        
        [everyGroupCountNum addObject:str];
    }
    NSString *one = @"0.00";
    [everyGroupCountNum insertObject:one atIndex:0];
    everyXY = everyGroupCountNum;
    for (int tap = 0; tap<everyGroupCountNum.count-1; tap++) {
        NSString *str = everyGroupCountNum[tap];
        CGFloat xxx = [str floatValue];
        
        NSString *str1 = everyGroupCountNum[tap+1];
        CGFloat xxx1 = [str1 floatValue];
        if (ySet>=xxx&&ySet&&ySet<xxx1) {
//            NSLog(@"------%d",tap);
            [self reSetLeftView:tap];
        }
        
    }

    if (ySet>=scrollView.contentSize.height-scrollView.frame.size.height-10) {
        [self reSetLeftView:cateGGArr.count-1];
    }
    
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    jianting = 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return leftArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell"];
    [cell loadWithDic:cateGGArr[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
- (void)reSetLeftView:(NSInteger)x{
    
        for (UIButton *b in leftScroll.subviews) {
            if ([b isKindOfClass:[UIButton class]]) {
                b.selected = NO;
            }
            if (b.tag-1000==x) {
                b.selected = YES;
                NSString *imgName = [NSString stringWithFormat:@"secondLeft%d",x];
//                [selImage setImage:[self createImageByName:imgName]];
                
//            NSLog(@"%f---%f",leftScroll.contentOffset.y,b.frame.origin.y+48);
                
                [self leftViewScrollTo:b.tag];
            }
        }
        
        
}
- (void)leftViewScrollTo:(NSInteger)x{
    UIButton *b ;
    for (UIButton *btn in leftScroll.subviews) {
        if (btn.tag==x) {
            b = btn;
        }
    }
//    NSLog(@"%f---%f",leftScroll.contentOffset.y,b.frame.origin.y+48);
        
    if (b.frame.origin.y-140<=0) {
        [UIView animateWithDuration:0.5 animations:^{
        [leftScroll setContentOffset:CGPointMake(0, 0)];
        }];
    }else if (b.frame.origin.y-140>=leftScroll.contentSize.height-300){
        [UIView animateWithDuration:0.5 animations:^{
        [leftScroll setContentOffset:CGPointMake(0, leftScroll.contentSize.height-300)];
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
        [leftScroll setContentOffset:CGPointMake(0, b.frame.origin.y-140)];
        }];
    }
        
        
    
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
