//
//  FifthView.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/12.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "FifthView.h"
#import "AppFaster.h"
#import "FifTableViewCell.h"
@implementation FifthView
{
    UITextField *searchTf;
    UITableView *myTableView;
    NSMutableArray *dataArr;
    NSString *keyWords;
    
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    
    
    return self;
}
- (void)setCarID:(NSString *)carID{
    _carID = carID;
    [self setUi];
    [self setTableView];
}
- (void)setUi{
    searchTf = [[UITextField alloc] initWithFrame:CGRectMake(47, 37, kScreenWidth-47-105, 30)];
    searchTf.layer.cornerRadius = 3;
    searchTf.layer.borderWidth = 1;
    searchTf.layer.borderColor = [[UIColor colorWithRed:104/255.0 green:119/255.0 blue:138/255.0 alpha:1] CGColor];
    searchTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 10)];
    searchTf.font = [UIFont systemFontOfSize:15];
    searchTf.textColor = [UIColor whiteColor];
    searchTf.leftViewMode = UITextFieldViewModeAlways;
    searchTf.tintColor = [UIColor whiteColor];
    [searchTf addTarget:self action:@selector(textdidchange:) forControlEvents:UIControlEventEditingChanged];
    searchTf.returnKeyType = UIReturnKeySearch;
    searchTf.delegate = self;
    [self addSubview:searchTf];
    
    UIImageView *fdj = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    [fdj setImage:[self getPictureWithName:@"fdjimage"]];
    [searchTf addSubview:fdj];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 16)];
//    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(searchTf.frame.size.width-16-10, 7, 16, 16)];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [closeBtn setImage:[self getPictureWithName:@"searchTFX"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(searchX) forControlEvents:UIControlEventTouchUpInside];
//    [searchTf addSubview:closeBtn];
    searchTf.rightView = rightView;
    [rightView addSubview:closeBtn];
    searchTf.rightViewMode = UITextFieldViewModeAlways;
    
}
- (void)textdidchange:(UITextField *)textField{
    if (textField.text.length==0) {
        [self createTableHeader];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchTf resignFirstResponder];
    
    [self searchGo:textField.text];
    return YES;
}
- (void)searchX{
    searchTf.text = @"";
    [self createTableHeader];
    [searchTf resignFirstResponder];
    [dataArr removeAllObjects];
    [myTableView reloadData];
}
- (void)setTableView{
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(35, 37+30+40, self.frame.size.width-35-105, self.frame.size.height-(37+30+40+64)) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    [[resourceBundle loadNibNamed:@"FifTableViewCell" owner:self options:nil] lastObject];
    
    [myTableView registerNib:[UINib nibWithNibName:@"FifTableViewCell" bundle:resourceBundle] forCellReuseIdentifier:@"FifTableViewCell"];
    
    [self addSubview:myTableView];
    if (dataArr.count==0) {
        [self createTableHeader];
    }else{
        myTableView.tableHeaderView = nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FifTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FifTableViewCell"];
    [cell loadWithData:dataArr[indexPath.row] andStr:keyWords :@"c229" ];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)searchGo:(NSString *)str{
    myTableView.tableHeaderView = nil;
    NSString *searcH = [self removeSpaceAndNewline:str];
    keyWords = searcH;
    NSString *newJsonStr = [NSString stringWithFormat:@"%@_news",_carID];
    NSDictionary *all = [self readLocalFileWithName:newJsonStr];
    NSArray *array = [all objectForKey:@"RECORDS"];
    dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    for (NSDictionary *d in array) {
        NSString *title = [NSString stringWithFormat:@"%@",d[@"title"]];
        if ([title containsString:searcH]) {
            [dataArr addObject:d];
        }
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *keysStr =[user objectForKey:@"c229gpch"];
    NSArray *keyArr = [keysStr componentsSeparatedByString:@","];
    if (![keyArr containsObject:str]) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:keyArr];
        [arr insertObject:str atIndex:0];
        [arr removeObjectAtIndex:arr.count-1];
        NSMutableString *str = [NSMutableString string];
        for (int i =0; i<arr.count; i++) {
            if (i == arr.count-1) {
                 str =[str stringByAppendingFormat:@"%@",arr[i]];
            }else{
                 str =[str stringByAppendingFormat:@"%@,",arr[i]];
            }
        }
        [user setObject:str forKey:@"c229gpch"];
    }
    [myTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self) {
        self.push(dataArr[indexPath.row]);
    }
}
- (NSString *)removeSpaceAndNewline:(NSString *)str{
    
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    return text;
}
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HSC229CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];

    // 获取文件路径
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
- (UIImage *)getPictureWithName:(NSString *)name{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"HSC229CarResource" ofType:@"bundle"]];
    NSString *path   = [bundle pathForResource:name ofType:@"png"];
    return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
-(void )createTableHeader{
    _tableHeader = nil;
    _tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myTableView.frame.size.width, 300)];
    _tableHeader.backgroundColor = [UIColor clearColor];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 100, 13)];
    title.text = @"高频搜索";
    title.font = [UIFont systemFontOfSize:13];
    title.textColor = [UIColor colorWithRed:131/255.0 green:135/255.0 blue:142/255.0 alpha:1];
    [_tableHeader addSubview:title];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *keysStr =[user objectForKey:@"c229gpch"];
    
    if (!keysStr) {
        NSString *gpch = @"方向盘,雾灯,爆胎,安全带";
        [[NSUserDefaults standardUserDefaults] setObject:gpch forKey:@"c229gpch"];
        keysStr = gpch;
    }else{
        keysStr = [user objectForKey:@"c229gpch"];
    }
    NSArray *keyArr = [keysStr componentsSeparatedByString:@","];
    for (int i =0; i<keyArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(8+(95+28)*i, 33, 95, 30)];
        [btn setTitle:keyArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor colorWithRed:131/255.0 green:135/255.0 blue:142/255.0 alpha:1] forState:UIControlStateNormal];
        [_tableHeader addSubview:btn];
        btn.layer.cornerRadius =3;
        btn.layer.borderColor =[[UIColor colorWithRed:197.0f/255.0f green:223.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
        btn.layer.borderWidth = 0.5;
        btn.backgroundColor = ([UIColor colorWithRed:21/255.0 green:24/255.0 blue:30/255.0 alpha:1]);
        btn.tag = i;
        [btn addTarget:self action:@selector(keySearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    myTableView.tableHeaderView = _tableHeader;
}
- (void)keySearch:(UIButton *)btn
{
    
    [self searchGo:btn.titleLabel.text];
    searchTf.text = btn.titleLabel.text;
}
@end
