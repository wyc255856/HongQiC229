//
//  C229CAR_MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASUtilities.h"

/**
 *	Enables Constraints to be created with chainable syntax
 *  Constraint can represent single NSLayoutConstraint (C229CAR_MASViewConstraint) 
 *  or a group of NSLayoutConstraints (C229CAR_MASComposisteConstraint)
 */
@interface C229CAR_MASConstraint : NSObject

// Chaining Support

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (C229CAR_MASConstraint * (^)(C229CAR_MASEdgeInsets insets))insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (C229CAR_MASConstraint * (^)(CGFloat inset))inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (C229CAR_MASConstraint * (^)(CGSize offset))sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (C229CAR_MASConstraint * (^)(CGPoint offset))centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (C229CAR_MASConstraint * (^)(CGFloat offset))offset;

/**
 *  Modifies the NSLayoutConstraint constant based on a value type
 */
- (C229CAR_MASConstraint * (^)(NSValue *value))valueOffset;

/**
 *	Sets the NSLayoutConstraint multiplier property
 */
- (C229CAR_MASConstraint * (^)(CGFloat multiplier))multipliedBy;

/**
 *	Sets the NSLayoutConstraint multiplier to 1.0/dividedBy
 */
- (C229CAR_MASConstraint * (^)(CGFloat divider))dividedBy;

/**
 *	Sets the NSLayoutConstraint priority to a float or C229CAR_MASLayoutPriority
 */
- (C229CAR_MASConstraint * (^)(C229CAR_MASLayoutPriority priority))priority;

/**
 *	Sets the NSLayoutConstraint priority to C229CAR_MASLayoutPriorityLow
 */
- (C229CAR_MASConstraint * (^)(void))priorityLow;

/**
 *	Sets the NSLayoutConstraint priority to C229CAR_MASLayoutPriorityMedium
 */
- (C229CAR_MASConstraint * (^)(void))priorityMedium;

/**
 *	Sets the NSLayoutConstraint priority to C229CAR_MASLayoutPriorityHigh
 */
- (C229CAR_MASConstraint * (^)(void))priorityHigh;

/**
 *	Sets the constraint relation to NSLayoutRelationEqual
 *  returns a block which accepts one of the following:
 *    C229CAR_MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (C229CAR_MASConstraint * (^)(id attr))equalTo;

/**
 *	Sets the constraint relation to NSLayoutRelationGreaterThanOrEqual
 *  returns a block which accepts one of the following:
 *    C229CAR_MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (C229CAR_MASConstraint * (^)(id attr))greaterThanOrEqualTo;

/**
 *	Sets the constraint relation to NSLayoutRelationLessThanOrEqual
 *  returns a block which accepts one of the following:
 *    C229CAR_MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (C229CAR_MASConstraint * (^)(id attr))lessThanOrEqualTo;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (C229CAR_MASConstraint *)with;

/**
 *	Optional semantic property which has no effect but improves the readability of constraint
 */
- (C229CAR_MASConstraint *)and;

/**
 *	Creates a new C229CAR_MASCompositeConstraint with the called attribute and reciever
 */
- (C229CAR_MASConstraint *)left;
- (C229CAR_MASConstraint *)top;
- (C229CAR_MASConstraint *)right;
- (C229CAR_MASConstraint *)bottom;
- (C229CAR_MASConstraint *)leading;
- (C229CAR_MASConstraint *)trailing;
- (C229CAR_MASConstraint *)width;
- (C229CAR_MASConstraint *)height;
- (C229CAR_MASConstraint *)centerX;
- (C229CAR_MASConstraint *)centerY;
- (C229CAR_MASConstraint *)baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (C229CAR_MASConstraint *)firstBaseline;
- (C229CAR_MASConstraint *)lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (C229CAR_MASConstraint *)leftMargin;
- (C229CAR_MASConstraint *)rightMargin;
- (C229CAR_MASConstraint *)topMargin;
- (C229CAR_MASConstraint *)bottomMargin;
- (C229CAR_MASConstraint *)leadingMargin;
- (C229CAR_MASConstraint *)trailingMargin;
- (C229CAR_MASConstraint *)centerXWithinMargins;
- (C229CAR_MASConstraint *)centerYWithinMargins;

#endif


/**
 *	Sets the constraint debug name
 */
- (C229CAR_MASConstraint * (^)(id key))key;

// NSLayoutConstraint constant Setters
// for use outside of c229_mas_updateConstraints/c229_mas_makeConstraints blocks

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInsets:(C229CAR_MASEdgeInsets)insets;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight
 */
- (void)setInset:(CGFloat)inset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeWidth, NSLayoutAttributeHeight
 */
- (void)setSizeOffset:(CGSize)sizeOffset;

/**
 *	Modifies the NSLayoutConstraint constant,
 *  only affects C229CAR_MASConstraints in which the first item's NSLayoutAttribute is one of the following
 *  NSLayoutAttributeCenterX, NSLayoutAttributeCenterY
 */
- (void)setCenterOffset:(CGPoint)centerOffset;

/**
 *	Modifies the NSLayoutConstraint constant
 */
- (void)setOffset:(CGFloat)offset;


// NSLayoutConstraint Installation support

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)
/**
 *  Whether or not to go through the animator proxy when modifying the constraint
 */
@property (nonatomic, copy, readonly) C229CAR_MASConstraint *animator;
#endif

/**
 *  Activates an NSLayoutConstraint if it's supported by an OS. 
 *  Invokes install otherwise.
 */
- (void)activate;

/**
 *  Deactivates previously installed/activated NSLayoutConstraint.
 */
- (void)deactivate;

/**
 *	Creates a NSLayoutConstraint and adds it to the appropriate view.
 */
- (void)install;

/**
 *	Removes previously installed NSLayoutConstraint
 */
- (void)uninstall;

@end


/**
 *  Convenience auto-boxing macros for C229CAR_MASConstraint methods.
 *
 *  Defining C229CAR_MAS_SHORTHAND_GLOBALS will turn on auto-boxing for default syntax.
 *  A potential drawback of this is that the unprefixed macros will appear in global scope.
 */
#define c229_mas_equalTo(...)                 equalTo(C229CAR_MASBoxValue((__VA_ARGS__)))
#define c229_mas_greaterThanOrEqualTo(...)    greaterThanOrEqualTo(C229CAR_MASBoxValue((__VA_ARGS__)))
#define c229_mas_lessThanOrEqualTo(...)       lessThanOrEqualTo(C229CAR_MASBoxValue((__VA_ARGS__)))

#define c229_mas_offset(...)                  valueOffset(C229CAR_MASBoxValue((__VA_ARGS__)))


#ifdef C229CAR_MAS_SHORTHAND_GLOBALS

#define equalTo(...)                     c229_mas_equalTo(__VA_ARGS__)
#define greaterThanOrEqualTo(...)        c229_mas_greaterThanOrEqualTo(__VA_ARGS__)
#define lessThanOrEqualTo(...)           c229_mas_lessThanOrEqualTo(__VA_ARGS__)

#define offset(...)                      c229_mas_offset(__VA_ARGS__)

#endif


@interface C229CAR_MASConstraint (AutoboxingSupport)

/**
 *  Aliases to corresponding relation methods (for shorthand macros)
 *  Also needed to aid autocompletion
 */
- (C229CAR_MASConstraint * (^)(id attr))c229_mas_equalTo;
- (C229CAR_MASConstraint * (^)(id attr))c229_mas_greaterThanOrEqualTo;
- (C229CAR_MASConstraint * (^)(id attr))c229_mas_lessThanOrEqualTo;

/**
 *  A dummy method to aid autocompletion
 */
- (C229CAR_MASConstraint * (^)(id offset))c229_mas_offset;

@end
