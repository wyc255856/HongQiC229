//
//  C229CAR_MASConstraint.m
//  Masonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "C229CAR_MASConstraint.h"
#import "C229CAR_MASConstraint+Private.h"

#define C229CAR_MASMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation C229CAR_MASConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[C229CAR_MASConstraint class]], @"C229CAR_MASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - NSLayoutRelation proxies

- (C229CAR_MASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (C229CAR_MASConstraint * (^)(id))c229_mas_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (C229CAR_MASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (C229CAR_MASConstraint * (^)(id))c229_mas_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (C229CAR_MASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (C229CAR_MASConstraint * (^)(id))c229_mas_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - C229CAR_MASLayoutPriority proxies

- (C229CAR_MASConstraint * (^)(void))priorityLow {
    return ^id{
        self.priority(C229CAR_MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(void))priorityMedium {
    return ^id{
        self.priority(C229CAR_MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(void))priorityHigh {
    return ^id{
        self.priority(C229CAR_MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (C229CAR_MASConstraint * (^)(C229CAR_MASEdgeInsets))insets {
    return ^id(C229CAR_MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(CGFloat))inset {
    return ^id(CGFloat inset){
        self.inset = inset;
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (C229CAR_MASConstraint * (^)(id offset))c229_mas_offset {
    // Will never be called due to macro
    return nil;
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(C229CAR_MASEdgeInsets)) == 0) {
        C229CAR_MASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (C229CAR_MASConstraint *)with {
    return self;
}

- (C229CAR_MASConstraint *)and {
    return self;
}

#pragma mark - Chaining

- (C229CAR_MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    C229CAR_MASMethodNotImplemented();
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

#pragma mark - Abstract

- (C229CAR_MASConstraint * (^)(CGFloat multiplier))multipliedBy { C229CAR_MASMethodNotImplemented(); }

- (C229CAR_MASConstraint * (^)(CGFloat divider))dividedBy { C229CAR_MASMethodNotImplemented(); }

- (C229CAR_MASConstraint * (^)(C229CAR_MASLayoutPriority priority))priority { C229CAR_MASMethodNotImplemented(); }

- (C229CAR_MASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { C229CAR_MASMethodNotImplemented(); }

- (C229CAR_MASConstraint * (^)(id key))key { C229CAR_MASMethodNotImplemented(); }

- (void)setInsets:(C229CAR_MASEdgeInsets __unused)insets { C229CAR_MASMethodNotImplemented(); }

- (void)setInset:(CGFloat __unused)inset { C229CAR_MASMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { C229CAR_MASMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { C229CAR_MASMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { C229CAR_MASMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (C229CAR_MASConstraint *)animator { C229CAR_MASMethodNotImplemented(); }

#endif

- (void)activate { C229CAR_MASMethodNotImplemented(); }

- (void)deactivate { C229CAR_MASMethodNotImplemented(); }

- (void)install { C229CAR_MASMethodNotImplemented(); }

- (void)uninstall { C229CAR_MASMethodNotImplemented(); }

@end
