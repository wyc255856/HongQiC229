//
//  TagBtn.m
//  HongQiC229
//
//  Created by 李卓轩 on 2019/12/27.
//  Copyright © 2019 Parry. All rights reserved.
//

#import "TagBtn.h"

@implementation TagBtn

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    return self;
}
- (void)setImage:(NSString *)name AndTitle:(NSString *)str{
    CGFloat imgWidth = self.frame.size.height-6;
    UIImage *image = [self createImageByName:name];
    CGFloat imgHeight = imgWidth*image.size.height/image.size.width;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-imgHeight)/2, self.frame.size.height-6, imgHeight)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.contentMode = UIViewContentModeScaleAspectFill;
    [img setImage:image];
    
    [self addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imgWidth+8, 0, 100, self.frame.size.height)];
    label.textColor = [UIColor whiteColor];
    label.text = str;
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
    img.userInteractionEnabled = NO;
    label.userInteractionEnabled = NO;
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
