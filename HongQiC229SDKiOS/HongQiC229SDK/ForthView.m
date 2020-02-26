//
//  ForthView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "ForthView.h"
#import "AppFaster.h"
#import "ForthCollectionViewCell.h"
#import "DetailViewController.h"
@implementation ForthView
{
    UIImageView *selImage;
    NSArray *leftArr;
    UICollectionView *myCollection;
    NSMutableArray *cellArr0;
    NSMutableArray *cellArr1;
    NSMutableArray *cellArr2;
    NSMutableArray *cellArr3;
    NSMutableArray *cellArr4;
    int jianting;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self loadData];
    [self setLeftView];
    [self setCollectionView];
    jianting = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNoty) name:@"unziped" object:nil];
    UIImageView *upYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*159/1920)];
    [upYinYing setImage:[self createImageByName:@"upYinYing"]];
    [self addSubview:upYinYing];
    
    UIImageView *downYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-kScreenWidth*192/1920, kScreenWidth, kScreenWidth*192/1920)];
    [downYinYing setImage:[self createImageByName:@"downYinYing"]];
//    [self addSubview:downYinYing];
    return self;
}
- (void)getNoty{
    [myCollection reloadData];
}
- (void)loadData{
    NSArray *catArr = [self readLocalFileWithName:@"229_category"];
    
    NSMutableArray *scArr = [NSMutableArray array];
    for (NSDictionary *ds in catArr) {
        if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"1869"]) {
            [scArr addObject:ds];
        }
    }
    
    leftArr = scArr;
    NSArray *newArr = [self readLocalFileWithName:@"229_news"];
    
    cellArr0 = [NSMutableArray array];
    cellArr1 = [NSMutableArray array];
    cellArr2 = [NSMutableArray array];
    cellArr3 = [NSMutableArray array];
    cellArr4 = [NSMutableArray array];
    
    for (NSDictionary *dic in newArr) {
        NSString *str0 = [NSString stringWithFormat:@"%@",scArr[0][@"caid"]];
        NSString *str1 = [NSString stringWithFormat:@"%@",scArr[1][@"caid"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",scArr[2][@"caid"]];
        NSString *str3 = [NSString stringWithFormat:@"%@",scArr[3][@"caid"]];
        NSString *str4 = [NSString stringWithFormat:@"%@",scArr[4][@"caid"]];
        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str0]) {
            [cellArr0 addObject:dic];
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str1]) {
            [cellArr1 addObject:dic];
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str2]) {
            [cellArr2 addObject:dic];
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str3]) {
            [cellArr3 addObject:dic];
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str4]) {
            [cellArr4 addObject:dic];
        }
    }
}
- (NSArray *)readLocalFileWithName:(NSString *)name {
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
    NSError *error;
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (!error) {
        return dic;
    }else{
        return nil;
    }
}
- (void)setLeftView{
    selImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 48, 300)];
    [selImage setImage:[self createImageByName:@"left0"]];
    [self addSubview: selImage];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(45, 56+48*i, 80, 48)];
        NSDictionary *dic = leftArr[i];
        [btn setTitle:[NSString stringWithFormat:@"%@",dic[@"catname"]] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = 1000+i;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:131/255.0 green:186/255.0 blue:255/255.0 alpha:1] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:btn];
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
- (void)leftBtnClick:(UIButton *)btn{
    jianting = 0;
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = NO;
        }
    }
    NSString *imgName = [NSString stringWithFormat:@"left%ld",btn.tag-1000];
    [selImage setImage:[self createImageByName:imgName]];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:btn.tag-1000];
    [myCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    btn.selected = YES;
}
- (void)setCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    
    myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(50+80, 33, kScreenWidth-50-80-10, self.frame.size.height-33-33) collectionViewLayout:layout];
    myCollection.backgroundColor = [UIColor clearColor];
    myCollection.delegate = self;
    myCollection.dataSource = self;
    [self addSubview:myCollection];
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    [[resourceBundle loadNibNamed:@"ForthCollectionViewCell" owner:self options:nil] lastObject];
     
    [myCollection registerNib:[UINib nibWithNibName:@"ForthCollectionViewCell" bundle:resourceBundle] forCellWithReuseIdentifier:@"ForthCollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return cellArr0.count;
    }else if (section ==1){
        return cellArr1.count;
    }else if (section ==2){
        return cellArr2.count;
    }else if (section ==3){
        return cellArr3.count;
    }else{
        return cellArr4.count;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width-40)/4, 95);
}

//header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGSizeMake(100, 20);
    }else{
        return CGSizeZero;
    }
    
}

//footer的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section==4) {
        return CGSizeMake(100, 20);
    }else{
        return CGSizeZero;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ForthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForthCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic;
    switch (indexPath.section) {
        case 0:
            dic = cellArr0[indexPath.row];
            break;
        case 1:
            dic = cellArr1[indexPath.row];
            break;
        case 2:
            dic = cellArr2[indexPath.row];
            break;
        case 3:
            dic = cellArr3[indexPath.row];
        break;
        case 4:
            dic = cellArr4[indexPath.row];
            break;
        default:
            break;
    }
    [cell loadWithDataDic:dic andTag:indexPath];
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat ySet = scrollView.contentOffset.y;
//    NSLog(@"%f",ySet);
//    NSInteger num0 = cellArr0.count/4;
//    if(cellArr0.count%4>0){
//        num0++;
//    }
//    NSInteger num1 = cellArr1.count/4;
//    if(cellArr1.count%4>0){
//        num1++;
//    }
//    NSInteger num2 = cellArr2.count/4;
//    if(cellArr2.count%4>0){
//        num2++;
//    }
//    NSInteger num3 = cellArr3.count/4;
//    if(cellArr3.count%4>0){
//        num3++;
//    }
//    NSInteger num4 = cellArr4.count/4;
//    if(cellArr4.count%4>0){
//        num4++;
//    }
    if (jianting == 0) {
        return;
    }
    UIButton *b0;UIButton *b1;UIButton *b2;UIButton *b3;UIButton *b4;
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            switch (b.tag) {
                case 1000:
                    b0 = b;
                    break;
                 case 1001:
                    b1 = b;
                    break;
                case 1002:
                    b2 = b;
                    break;
                case 1003:
                    b3 = b;
                    break;
                case 1004:
                    b4 = b;
                    break;
                default:
                    break;
            }
            b.selected = NO;
        }
    }
    
    
    UIButton *lastBtn;
    if (ySet<=160) {
//        NSLog(@"0");
        lastBtn = b0;
    }
    if (160<ySet&&ySet<=355) {
//        NSLog(@"1");
        lastBtn = b1;
    }
    if(355<ySet&&ySet<=442){
//        NSLog(@"2");
        lastBtn = b2;
    }
    if (442<ySet&&ySet<=636) {
//        NSLog(@"3");
        lastBtn = b3;
    }
    if (ySet>636) {
//        NSLog(@"4");
        lastBtn = b4;
    }
    NSString *imgName = [NSString stringWithFormat:@"left%ld",lastBtn.tag-1000];
    [selImage setImage:[self createImageByName:imgName]];
    lastBtn.selected = YES;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    jianting = 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic;
    switch (indexPath.section) {
        case 0:
            dic = cellArr0[indexPath.row];
            break;
        case 1:
            dic = cellArr1[indexPath.row];
            break;
        case 2:
            dic = cellArr2[indexPath.row];
            break;
        case 3:
            dic = cellArr3[indexPath.row];
        break;
        case 4:
            dic = cellArr4[indexPath.row];
            break;
        default:
            break;
    }
    if (self) {
        self.push(dic);
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
