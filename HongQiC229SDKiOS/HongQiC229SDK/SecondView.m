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
@implementation SecondView
{
    UIImageView *selImage;
    NSArray *leftArr;
    UICollectionView *myCollection;
    int jianting;
    NSMutableDictionary *allDic;
    UITableView *leftTableView;
    NSMutableArray *cateGGArr;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    [self loadData];
    [self setLeftView];
    [self setCollectionView];
//    [self setTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNoty) name:@"unziped" object:nil];
    jianting = 1;
    
    return self;
}
- (void)getNoty{
    [myCollection reloadData];
}
- (void)loadData{
    NSDictionary *categoryDic = [self readLocalFileWithName:@"zy_category"];
    NSArray *catArr = categoryDic[@"RECORDS"];
    NSMutableArray *scArr = [NSMutableArray array];
    cateGGArr = [NSMutableArray array];
    for (NSDictionary *ds in catArr) {
        if ([[NSString stringWithFormat:@"%@",ds[@"parentid"]] isEqualToString:@"1855"]) {
            [scArr addObject:[NSString stringWithFormat:@"%@",ds[@"caid"]]];
            [cateGGArr addObject:ds];
        }
    }
    
    leftArr = scArr;
    NSDictionary *newsDic = [self readLocalFileWithName:@"zy_news"];
    NSArray *newArr = newsDic[@"RECORDS"];
   
    //
    allDic =[NSMutableDictionary dictionary];
    for (NSString *catID in scArr) {
        NSMutableArray *catArr = [NSMutableArray array];
        [allDic setObject:catArr forKey:catID];
    }
    for (NSDictionary *dic in newArr) {
        for (NSString *catID in scArr) {
            NSString *catId = catID;
            NSString *newId = [NSString stringWithFormat:@"%@",dic[@"caid"]];
            if ([catId isEqualToString:newId]) {
                NSMutableArray *newArr = [allDic objectForKey:newId];
                [newArr addObject:dic];
                [allDic setObject:newArr forKey:newId];
            }
        }
    }
    //
//    for (NSDictionary *dic in newArr) {
//        NSString *str0 = [NSString stringWithFormat:@"%@",scArr[0][@"caid"]];
//        NSString *str1 = [NSString stringWithFormat:@"%@",scArr[1][@"caid"]];
//        NSString *str2 = [NSString stringWithFormat:@"%@",scArr[2][@"caid"]];
//        NSString *str3 = [NSString stringWithFormat:@"%@",scArr[3][@"caid"]];
//        NSString *str4 = [NSString stringWithFormat:@"%@",scArr[4][@"caid"]];
//        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str0]) {
//            [cellArr0 addObject:dic];
//        }
//        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str1]) {
//            [cellArr1 addObject:dic];
//        }
//        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str2]) {
//            [cellArr2 addObject:dic];
//        }
//        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str3]) {
//            [cellArr3 addObject:dic];
//        }
//        if ([[NSString stringWithFormat:@"%@",dic[@"caid"]] isEqualToString:str4]) {
//            [cellArr4 addObject:dic];
//        }
//    }
}
- (void)setLeftView{
    
    selImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 48, 300)];
    [selImage setImage:[UIImage imageNamed:@"left0"]];
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
    
    [myCollection registerNib:[UINib nibWithNibName:@"ForthCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ForthCollectionViewCell"];
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
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat ySet = scrollView.contentOffset.y;
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
    if (ySet<=151) {
        NSLog(@"0");
        lastBtn = b0;
    }
    if (151<ySet&&ySet<=350) {
        NSLog(@"1");
        lastBtn = b1;
    }
    if(350<ySet&&ySet<=449){
        NSLog(@"2");
        lastBtn = b2;
    }
    if (449<ySet&&ySet<=635) {
        NSLog(@"3");
        lastBtn = b3;
    }
    if (ySet>635) {
        NSLog(@"4");
        lastBtn = b4;
    }
    NSString *imgName = [NSString stringWithFormat:@"left%ld",lastBtn.tag-1000];
    [selImage setImage:[UIImage imageNamed:imgName]];
    lastBtn.selected = YES;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    jianting = 1;
    
}

- (void)setTableView{
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 128, 300) style:UITableViewStylePlain];
    leftTableView.backgroundColor = [UIColor clearColor];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
       NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
       NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    [[resourceBundle loadNibNamed:@"SecondTableViewCell" owner:self options:nil] lastObject];
    
    [leftTableView registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:resourceBundle] forCellReuseIdentifier:@"SecondTableViewCell"];
    [self addSubview:leftTableView];
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
@end
