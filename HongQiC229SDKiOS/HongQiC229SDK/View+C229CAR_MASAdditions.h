//
//  UIC229CAR+View+C229CAR_MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASUtilities.h"
#import "C229CAR_MASConstraintMaker.h"
#import "C229CAR_MASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating C229CAR_MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface C229CAR_MAS_VIEW (C229CAR_MASAdditions)

/**
 *	following properties return a new C229CAR_MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_left;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_top;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_right;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_bottom;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_leading;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_trailing;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_width;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_height;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_centerX;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_centerY;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_baseline;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *(^c229_mas_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_firstBaseline;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_leftMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_rightMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_topMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_bottomMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_leadingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_trailingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_safeAreaLayoutGuide API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id c229_mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)c229_mas_closestCommonSuperview:(C229CAR_MAS_VIEW *)view;

/**
 *  Creates a C229CAR_MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_makeConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

/**
 *  Creates a C229CAR_MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_updateConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

/**
 *  Creates a C229CAR_MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_remakeConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

@end
