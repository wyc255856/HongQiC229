//
//  UIC229CAR+View+C229CAR_MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+C229CAR_MASAdditions.h"
#import <objc/runtime.h>

@implementation C229CAR_MAS_VIEW (C229CAR_MASAdditions)

- (NSArray *)c229_mas_makeConstraints:(void(^)(C229CAR_MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    C229CAR_MASConstraintMaker *constraintMaker = [[C229CAR_MASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)c229_mas_updateConstraints:(void(^)(C229CAR_MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    C229CAR_MASConstraintMaker *constraintMaker = [[C229CAR_MASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)c229_mas_remakeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    C229CAR_MASConstraintMaker *constraintMaker = [[C229CAR_MASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (C229CAR_MASViewAttribute *)c229_mas_left {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (C229CAR_MASViewAttribute *)c229_mas_top {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (C229CAR_MASViewAttribute *)c229_mas_right {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (C229CAR_MASViewAttribute *)c229_mas_bottom {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (C229CAR_MASViewAttribute *)c229_mas_leading {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (C229CAR_MASViewAttribute *)c229_mas_trailing {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (C229CAR_MASViewAttribute *)c229_mas_width {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (C229CAR_MASViewAttribute *)c229_mas_height {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (C229CAR_MASViewAttribute *)c229_mas_centerX {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (C229CAR_MASViewAttribute *)c229_mas_centerY {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (C229CAR_MASViewAttribute *)c229_mas_baseline {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (C229CAR_MASViewAttribute *(^)(NSLayoutAttribute))c229_mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (C229CAR_MASViewAttribute *)c229_mas_firstBaseline {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (C229CAR_MASViewAttribute *)c229_mas_lastBaseline {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (C229CAR_MASViewAttribute *)c229_mas_leftMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_rightMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_topMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_bottomMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_leadingMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_trailingMargin {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (C229CAR_MASViewAttribute *)c229_mas_centerXWithinMargins {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (C229CAR_MASViewAttribute *)c229_mas_centerYWithinMargins {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

- (C229CAR_MASViewAttribute *)c229_mas_safeAreaLayoutGuide {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (C229CAR_MASViewAttribute *)c229_mas_safeAreaLayoutGuideTop {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (C229CAR_MASViewAttribute *)c229_mas_safeAreaLayoutGuideBottom {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (C229CAR_MASViewAttribute *)c229_mas_safeAreaLayoutGuideLeft {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}
- (C229CAR_MASViewAttribute *)c229_mas_safeAreaLayoutGuideRight {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

#endif

#pragma mark - associated properties

- (id)c229_mas_key {
    return objc_getAssociatedObject(self, @selector(c229_mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(c229_mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)c229_mas_closestCommonSuperview:(C229CAR_MAS_VIEW *)view {
    C229CAR_MAS_VIEW *closestCommonSuperview = nil;

    C229CAR_MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        C229CAR_MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
