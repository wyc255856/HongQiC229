//
//  C229CAR_MASConstraintMaker.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASConstraintMaker.h"
#import "C229CAR_MASViewConstraint.h"
#import "C229CAR_MASCompositeConstraint.h"
#import "C229CAR_MASConstraint+Private.h"
#import "C229CAR_MASViewAttribute.h"
#import "View+C229CAR_MASAdditions.h"

@interface C229CAR_MASConstraintMaker () <C229CAR_MASConstraintDelegate>

@property (nonatomic, weak) C229CAR_MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation C229CAR_MASConstraintMaker

- (id)initWithView:(C229CAR_MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [C229CAR_MASViewConstraint installedConstraintsForView:self.view];
        for (C229CAR_MASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (C229CAR_MASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - C229CAR_MASConstraintDelegate

- (void)constraint:(C229CAR_MASConstraint *)constraint shouldBeReplacedWithConstraint:(C229CAR_MASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (C229CAR_MASConstraint *)constraint:(C229CAR_MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    C229CAR_MASViewAttribute *viewAttribute = [[C229CAR_MASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    C229CAR_MASViewConstraint *newConstraint = [[C229CAR_MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:C229CAR_MASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        C229CAR_MASCompositeConstraint *compositeConstraint = [[C229CAR_MASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (C229CAR_MASConstraint *)addConstraintWithAttributes:(C229CAR_MASAttribute)attrs {
    __unused C229CAR_MASAttribute anyAttribute = (C229CAR_MASAttributeLeft | C229CAR_MASAttributeRight | C229CAR_MASAttributeTop | C229CAR_MASAttributeBottom | C229CAR_MASAttributeLeading
                                          | C229CAR_MASAttributeTrailing | C229CAR_MASAttributeWidth | C229CAR_MASAttributeHeight | C229CAR_MASAttributeCenterX
                                          | C229CAR_MASAttributeCenterY | C229CAR_MASAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | C229CAR_MASAttributeFirstBaseline | C229CAR_MASAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | C229CAR_MASAttributeLeftMargin | C229CAR_MASAttributeRightMargin | C229CAR_MASAttributeTopMargin | C229CAR_MASAttributeBottomMargin
                                          | C229CAR_MASAttributeLeadingMargin | C229CAR_MASAttributeTrailingMargin | C229CAR_MASAttributeCenterXWithinMargins
                                          | C229CAR_MASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & C229CAR_MASAttributeLeft) [attributes addObject:self.view.c229_mas_left];
    if (attrs & C229CAR_MASAttributeRight) [attributes addObject:self.view.c229_mas_right];
    if (attrs & C229CAR_MASAttributeTop) [attributes addObject:self.view.c229_mas_top];
    if (attrs & C229CAR_MASAttributeBottom) [attributes addObject:self.view.c229_mas_bottom];
    if (attrs & C229CAR_MASAttributeLeading) [attributes addObject:self.view.c229_mas_leading];
    if (attrs & C229CAR_MASAttributeTrailing) [attributes addObject:self.view.c229_mas_trailing];
    if (attrs & C229CAR_MASAttributeWidth) [attributes addObject:self.view.c229_mas_width];
    if (attrs & C229CAR_MASAttributeHeight) [attributes addObject:self.view.c229_mas_height];
    if (attrs & C229CAR_MASAttributeCenterX) [attributes addObject:self.view.c229_mas_centerX];
    if (attrs & C229CAR_MASAttributeCenterY) [attributes addObject:self.view.c229_mas_centerY];
    if (attrs & C229CAR_MASAttributeBaseline) [attributes addObject:self.view.c229_mas_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & C229CAR_MASAttributeFirstBaseline) [attributes addObject:self.view.c229_mas_firstBaseline];
    if (attrs & C229CAR_MASAttributeLastBaseline) [attributes addObject:self.view.c229_mas_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & C229CAR_MASAttributeLeftMargin) [attributes addObject:self.view.c229_mas_leftMargin];
    if (attrs & C229CAR_MASAttributeRightMargin) [attributes addObject:self.view.c229_mas_rightMargin];
    if (attrs & C229CAR_MASAttributeTopMargin) [attributes addObject:self.view.c229_mas_topMargin];
    if (attrs & C229CAR_MASAttributeBottomMargin) [attributes addObject:self.view.c229_mas_bottomMargin];
    if (attrs & C229CAR_MASAttributeLeadingMargin) [attributes addObject:self.view.c229_mas_leadingMargin];
    if (attrs & C229CAR_MASAttributeTrailingMargin) [attributes addObject:self.view.c229_mas_trailingMargin];
    if (attrs & C229CAR_MASAttributeCenterXWithinMargins) [attributes addObject:self.view.c229_mas_centerXWithinMargins];
    if (attrs & C229CAR_MASAttributeCenterYWithinMargins) [attributes addObject:self.view.c229_mas_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (C229CAR_MASViewAttribute *a in attributes) {
        [children addObject:[[C229CAR_MASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    C229CAR_MASCompositeConstraint *constraint = [[C229CAR_MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (C229CAR_MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (C229CAR_MASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (C229CAR_MASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (C229CAR_MASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (C229CAR_MASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (C229CAR_MASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (C229CAR_MASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (C229CAR_MASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (C229CAR_MASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (C229CAR_MASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (C229CAR_MASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (C229CAR_MASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (C229CAR_MASConstraint *(^)(C229CAR_MASAttribute))attributes {
    return ^(C229CAR_MASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (C229CAR_MASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (C229CAR_MASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (C229CAR_MASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (C229CAR_MASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (C229CAR_MASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (C229CAR_MASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (C229CAR_MASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (C229CAR_MASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (C229CAR_MASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (C229CAR_MASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (C229CAR_MASConstraint *)edges {
    return [self addConstraintWithAttributes:C229CAR_MASAttributeTop | C229CAR_MASAttributeLeft | C229CAR_MASAttributeRight | C229CAR_MASAttributeBottom];
}

- (C229CAR_MASConstraint *)size {
    return [self addConstraintWithAttributes:C229CAR_MASAttributeWidth | C229CAR_MASAttributeHeight];
}

- (C229CAR_MASConstraint *)center {
    return [self addConstraintWithAttributes:C229CAR_MASAttributeCenterX | C229CAR_MASAttributeCenterY];
}

#pragma mark - grouping

- (C229CAR_MASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        C229CAR_MASCompositeConstraint *constraint = [[C229CAR_MASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
