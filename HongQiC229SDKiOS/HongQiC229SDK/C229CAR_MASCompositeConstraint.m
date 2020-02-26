//
//  C229CAR_MASCompositeConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASCompositeConstraint.h"
#import "C229CAR_MASConstraint+Private.h"

@interface C229CAR_MASCompositeConstraint () <C229CAR_MASConstraintDelegate>

@property (nonatomic, strong) id c229_mas_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation C229CAR_MASCompositeConstraint

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;

    _childConstraints = [children mutableCopy];
    for (C229CAR_MASConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }

    return self;
}

#pragma mark - C229CAR_MASConstraintDelegate

- (void)constraint:(C229CAR_MASConstraint *)constraint shouldBeReplacedWithConstraint:(C229CAR_MASConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (C229CAR_MASConstraint *)constraint:(C229CAR_MASConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<C229CAR_MASConstraintDelegate> strongDelegate = self.delegate;
    C229CAR_MASConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (C229CAR_MASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (C229CAR_MASConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (C229CAR_MASConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

#pragma mark - C229CAR_MASLayoutPriority proxy

- (C229CAR_MASConstraint * (^)(C229CAR_MASLayoutPriority))priority {
    return ^id(C229CAR_MASLayoutPriority priority) {
        for (C229CAR_MASConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

#pragma mark - NSLayoutRelation proxy

- (C229CAR_MASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (C229CAR_MASConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

#pragma mark - attribute chaining

- (C229CAR_MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}

#pragma mark - Animator proxy

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (C229CAR_MASConstraint *)animator {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}

#endif

#pragma mark - debug helpers

- (C229CAR_MASConstraint * (^)(id))key {
    return ^id(id key) {
        self.c229_mas_key = key;
        int i = 0;
        for (C229CAR_MASConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setters

- (void)setInsets:(C229CAR_MASEdgeInsets)insets {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}

- (void)setInset:(CGFloat)inset {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.inset = inset;
    }
}

- (void)setOffset:(CGFloat)offset {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}

#pragma mark - C229CAR_MASConstraint

- (void)activate {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}

- (void)deactivate {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}

- (void)install {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (C229CAR_MASConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end
