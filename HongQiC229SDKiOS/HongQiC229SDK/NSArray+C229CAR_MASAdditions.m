//
//  NSArray+C229CAR_MASAdditions.m
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+C229CAR_MASAdditions.h"
#import "View+C229CAR_MASAdditions.h"

@implementation NSArray (C229CAR_MASAdditions)

- (NSArray *)c229_mas_makeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (C229CAR_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[C229CAR_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view c229_mas_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)c229_mas_updateConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (C229CAR_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[C229CAR_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view c229_mas_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)c229_mas_remakeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (C229CAR_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[C229CAR_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view c229_mas_remakeConstraints:block]];
    }
    return constraints;
}

- (void)c229_mas_distributeViewsAlongAxis:(C229CAR_MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    C229CAR_MAS_VIEW *tempSuperView = [self c229_mas_commonSuperviewOfViews];
    if (axisType == C229CAR_MASAxisTypeHorizontal) {
        C229CAR_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            C229CAR_MAS_VIEW *v = self[i];
            [v c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.c229_mas_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        C229CAR_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            C229CAR_MAS_VIEW *v = self[i];
            [v c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.c229_mas_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)c229_mas_distributeViewsAlongAxis:(C229CAR_MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    C229CAR_MAS_VIEW *tempSuperView = [self c229_mas_commonSuperviewOfViews];
    if (axisType == C229CAR_MASAxisTypeHorizontal) {
        C229CAR_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            C229CAR_MAS_VIEW *v = self[i];
            [v c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.width.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        C229CAR_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            C229CAR_MAS_VIEW *v = self[i];
            [v c229_mas_makeConstraints:^(C229CAR_MASConstraintMaker *make) {
                make.height.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (C229CAR_MAS_VIEW *)c229_mas_commonSuperviewOfViews
{
    C229CAR_MAS_VIEW *commonSuperview = nil;
    C229CAR_MAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[C229CAR_MAS_VIEW class]]) {
            C229CAR_MAS_VIEW *view = (C229CAR_MAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view c229_mas_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
