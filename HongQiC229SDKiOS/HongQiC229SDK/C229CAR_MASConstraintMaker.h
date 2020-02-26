//
//  C229CAR_MASConstraintMaker.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASConstraint.h"
#import "C229CAR_MASUtilities.h"

typedef NS_OPTIONS(NSInteger, C229CAR_MASAttribute) {
    C229CAR_MASAttributeLeft = 1 << NSLayoutAttributeLeft,
    C229CAR_MASAttributeRight = 1 << NSLayoutAttributeRight,
    C229CAR_MASAttributeTop = 1 << NSLayoutAttributeTop,
    C229CAR_MASAttributeBottom = 1 << NSLayoutAttributeBottom,
    C229CAR_MASAttributeLeading = 1 << NSLayoutAttributeLeading,
    C229CAR_MASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    C229CAR_MASAttributeWidth = 1 << NSLayoutAttributeWidth,
    C229CAR_MASAttributeHeight = 1 << NSLayoutAttributeHeight,
    C229CAR_MASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    C229CAR_MASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    C229CAR_MASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    C229CAR_MASAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    C229CAR_MASAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    C229CAR_MASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    C229CAR_MASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    C229CAR_MASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    C229CAR_MASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    C229CAR_MASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    C229CAR_MASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    C229CAR_MASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    C229CAR_MASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating C229CAR_MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface C229CAR_MASConstraintMaker : NSObject

/**
 *	The following properties return a new C229CAR_MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate C229CAR_MASViewAttribute
 */
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *left;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *top;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *right;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *bottom;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *leading;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *trailing;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *width;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *height;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *centerX;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *centerY;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) C229CAR_MASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) C229CAR_MASConstraint *leftMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *rightMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *topMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new C229CAR_MASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  C229CAR_MASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *(^attributes)(C229CAR_MASAttribute attrs);

/**
 *	Creates a C229CAR_MASCompositeConstraint with type C229CAR_MASCompositeConstraintTypeEdges
 *  which generates the appropriate C229CAR_MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *edges;

/**
 *	Creates a C229CAR_MASCompositeConstraint with type C229CAR_MASCompositeConstraintTypeSize
 *  which generates the appropriate C229CAR_MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *size;

/**
 *	Creates a C229CAR_MASCompositeConstraint with type C229CAR_MASCompositeConstraintTypeCenter
 *  which generates the appropriate C229CAR_MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) C229CAR_MASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any C229CAR_MASConstraint are created with this view as the first item
 *
 *	@return	a new C229CAR_MASConstraintMaker
 */
- (id)initWithView:(C229CAR_MAS_VIEW *)view;

/**
 *	Calls install method on any C229CAR_MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed C229CAR_MASConstraints
 */
- (NSArray *)install;

- (C229CAR_MASConstraint * (^)(dispatch_block_t))group;

@end
