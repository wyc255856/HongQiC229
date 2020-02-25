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
    [self setUi];
    [self setTableView];
    
    return self;
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
    searchTf.returnKeyType = UIReturnKeySearch;
    searchTf.delegate = self;
    [self addSubview:searchTf];
    
    UIImageView *fdj = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 15, 15)];
    [fdj setImage:[UIImage imageNamed:@"fdjimage"]];
    [searchTf addSubview:fdj];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 16)];
//    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(searchTf.frame.size.width-16-10, 7, 16, 16)];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    [closeBtn setImage:[UIImage imageNamed:@"searchTFX"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(searchX) forControlEvents:UIControlEventTouchUpInside];
//    [searchTf addSubview:closeBtn];
    searchTf.rightView = rightView;
    [rightView addSubview:closeBtn];
    searchTf.rightViewMode = UITextFieldViewModeAlways;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [searchTf resignFirstResponder];
    [self searchGo:textField.text];
    return YES;
}
- (void)searchX{
    searchTf.text = @"";
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
    
    #define kZLPhotoBrowserBundle [NSBundle bundleForClass:[self class]]
    [[kZLPhotoBrowserBundle loadNibNamed:@"FifTableViewCell" owner:self options:nil] lastObject];
    
    [myTableView registerNib:[UINib nibWithNibName:@"FifTableViewCell" bundle:kZLPhotoBrowserBundle] forCellReuseIdentifier:@"FifTableViewCell"];
    
    [self addSubview:myTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FifTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FifTableViewCell"];
    [cell loadWithData:dataArr[indexPath.row] andStr:keyWords];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)searchGo:(NSString *)str{
    NSString *searcH = [self removeSpaceAndNewline:str];
    keyWords = searcH;
    NSDictionary *all = [self readLocalFileWithName:@"zy_news"];
    NSArray *array = [all objectForKey:@"RECORDS"];
    dataArr = [NSMutableArray array];
    [dataArr removeAllObjects];
    for (NSDictionary *d in array) {
        NSString *title = [NSString stringWithFormat:@"%@",d[@"title"]];
        if ([title containsString:searcH]) {
            [dataArr addObject:d];
        }
    }
    [myTableView reloadData];
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
@end
