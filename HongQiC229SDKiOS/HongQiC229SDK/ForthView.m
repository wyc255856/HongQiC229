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
#import "C229SectionHeader.h"
@implementation ForthView
{
    UIImageView *selImage;
    NSMutableArray *leftArr;
    UICollectionView *myCollection;
    NSMutableArray *cellArr0;
    NSMutableArray *cellArr1;
    NSMutableArray *cellArr2;
    NSMutableArray *cellArr3;
    NSMutableArray *cellArr4;
    int jianting;
    NSMutableDictionary *allDic;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    
    return self;
}
- (void)setCarID:(NSString *)carID{
    _carID = carID;
    leftArr = [NSMutableArray array];
    [self loadData];
    UIImageView *downYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-kScreenWidth*192/1920, kScreenWidth, kScreenWidth*192/1920)];
    
    [self setCollectionView];
    [downYinYing setImage:[self createImageByName:@"downYinYing"]];
    [self addSubview:downYinYing];
    [self setLeftView];
    
    jianting = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNoty) name:@"unziped" object:nil];
    UIImageView *upYinYing = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*159/1920)];
    [upYinYing setImage:[self createImageByName:@"upYinYing"]];
    [self addSubview:upYinYing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"c229chooseModel" object:nil];
}
- (void)getNoty{
    [myCollection reloadData];
}
- (void)loadData{
    NSString *str = [NSString stringWithFormat:@"%@_category",self.carID];
    NSDictionary *catdic = [self readLocalFileWithName:str];
    NSArray *catArr = catdic[@"RECORDS"];
    NSMutableArray *scArr = [NSMutableArray array];
    
    for (NSDictionary *ds in catArr) {
        if ([self.carID isEqualToString:@"C229"]) {
            if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"1869"]) {
                [scArr addObject:ds];
            }
        }else if (  [self.carID isEqualToString:@"E115"]){
            if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"17"]) {
                [scArr addObject:ds];
            }
        }
         
    }
    leftArr = [NSMutableArray array];
    for (NSDictionary *dc in scArr) {
        [leftArr addObject:dc];
    }
    for (NSDictionary *dc in scArr) {
        int x = [[dc objectForKey:@"catid"] intValue];
        [leftArr removeObject:dc];
        for (int i=0; i<leftArr.count;i++ ) {
            int y = [[leftArr[i] objectForKey:@"catid"] intValue];
            if (x<y) {
                [leftArr insertObject:dc atIndex:i];
                break;
            }
            if (i==leftArr.count-1&&leftArr.count<scArr.count) {
                [leftArr insertObject:dc atIndex:i];
            }
        }
    }
    
    
    NSString *newsStr = [NSString stringWithFormat:@"%@_news",_carID];
    NSDictionary *newdic = [self readLocalFileWithName:newsStr];
    NSArray *newArr = newdic[@"RECORDS"];
    cellArr0 = [NSMutableArray array];
    cellArr1 = [NSMutableArray array];
    cellArr2 = [NSMutableArray array];
    cellArr3 = [NSMutableArray array]; 
    cellArr4 = [NSMutableArray array];
    allDic = [NSMutableDictionary dictionary];
    NSString *chooseStr = [NSString stringWithFormat:@"%@ModelChoose",_carID];
    for (NSDictionary *dic in newArr) {
        NSString *str0 = [NSString stringWithFormat:@"%@",leftArr[0][@"catid"]];
        NSString *str1 = [NSString stringWithFormat:@"%@",leftArr[1][@"catid"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",leftArr[2][@"catid"]];
        NSString *str3 = [NSString stringWithFormat:@"%@",leftArr[3][@"catid"]];
        NSString *str4 = [NSString stringWithFormat:@"%@",leftArr[4][@"catid"]];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([[NSString stringWithFormat:@"%@",dic[@"catid"]] isEqualToString:str0]) {
            NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
            if ([model isEqualToString:@"1"]) {
                [cellArr0 addObject:dic];
            }
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"catid"]] isEqualToString:str1]) {
            NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
            if ([model isEqualToString:@"1"]) {
                [cellArr1 addObject:dic];
            }
            
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"catid"]] isEqualToString:str2]) {
            NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
            if ([model isEqualToString:@"1"]) {
                [cellArr2 addObject:dic];
            }
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"catid"]] isEqualToString:str3]) {
            NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
            if ([model isEqualToString:@"1"]) {
                [cellArr3 addObject:dic];
            }
        }
        if ([[NSString stringWithFormat:@"%@",dic[@"catid"]] isEqualToString:str4]) {
            NSString *model = [dic objectForKey:[user objectForKey:chooseStr]];
            if ([model isEqualToString:@"1"]) {
                [cellArr4 addObject:dic];
            }
        }
        [allDic setObject:cellArr0 forKey:str0];
        [allDic setObject:cellArr1 forKey:str1];
        [allDic setObject:cellArr2 forKey:str2];
        [allDic setObject:cellArr3 forKey:str3];
        [allDic setObject:cellArr4 forKey:str4];
    }
    
    [myCollection reloadData];
    
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
- (void)setLeftView{
//    selImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 18, 48, 300)];
//    [selImage setImage:[self createImageByName:@"left0"]];
//    [self addSubview: selImage];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(45, 40+48*i, 80, 48)];
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
    NSMutableArray *everyGroupCountNum = [NSMutableArray array];
    
    for (NSDictionary *dic in leftArr) {
        NSString *key = [NSString stringWithFormat:@"%@",dic[@"catid"]];
        NSArray *everyArr = [allDic objectForKey:key];
        int count = everyArr.count/4;
        if (everyArr.count%4>0) {
            count = count+1;
        }
        CGFloat they = count *98.00+50;
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
    
    
    jianting = 0;
    for (UIButton *b in self.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = NO;
        }
    }
    NSString *imgName = [NSString stringWithFormat:@"left%ld",btn.tag-1000];
//    [selImage setImage:[self createImageByName:imgName]];
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:btn.tag-1000];
    NSString *yStr = [everyGroupCountNum objectAtIndex:btn.tag-1000];
    CGFloat yyy = [yStr floatValue];
    [myCollection setContentOffset:CGPointMake(0, yyy) animated:YES];
    btn.selected = YES;
}
- (void)setCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    
    myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(50+80, 33, kScreenWidth-50-80-10, self.frame.size.height-33-33+40) collectionViewLayout:layout];
    myCollection.backgroundColor = [UIColor clearColor];
    myCollection.delegate = self;
    myCollection.dataSource = self;
    [self addSubview:myCollection];
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    [myCollection registerClass:[C229SectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: @"C229SectionHeader"];
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
   
    return CGSizeMake(100, 50);
    
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader)
    {
        C229SectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"C229SectionHeader" forIndexPath:indexPath];

        NSDictionary *dic = leftArr[indexPath.section];

        headerView.titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"catname"]];
        reusableview = headerView;
    }else{
        C229SectionHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"C229SectionHeader" forIndexPath:indexPath];
        headerView.titleLabel.text = @"";
        reusableview = headerView;
    }



    return reusableview;
}
//footer的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    if (section==4) {
        return CGSizeMake(100, 30);
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
    if (jianting==0) {
        return;
    }
    NSMutableArray *everyGroupCountNum = [NSMutableArray array];
    
    for (NSDictionary *dic in leftArr) {
        NSString *key = [NSString stringWithFormat:@"%@",dic[@"catid"]];
        NSArray *everyArr = [allDic objectForKey:key];
        int count = everyArr.count/4;
        if (everyArr.count%4>0) {
            count = count+1;
        }
        CGFloat they = count *98.00+50;
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
    if (ySet+scrollView.frame.size.height>=scrollView.contentSize.height-10) {
        [self reSetLeftView:4];
    }

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
- (void)reSetLeftView:(NSInteger)x{
    
        for (UIButton *b in self.subviews) {
            if ([b isKindOfClass:[UIButton class]]) {
                b.selected = NO;
            }
            if (b.tag-1000==x) {
                b.selected = YES;
                NSString *imgName = [NSString stringWithFormat:@"left%ld",x];
//                [selImage setImage:[self createImageByName:imgName]];
            }
            }
        
    
        
}
@end
