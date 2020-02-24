//
//  C229CAR_MASViewConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASViewAttribute.h"
#import "C229CAR_MASConstraint.h"
#import "C229CAR_MASLayoutConstraint.h"
#import "C229CAR_MASUtilities.h"

/**
 *  A single constraint.
 *  Contains the attributes neccessary for creating a NSLayoutConstraint and adding it to the appropriate view
 */
@interface C229CAR_MASViewConstraint : C229CAR_MASConstraint <NSCopying>

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *secondViewAttribute;

/**
 *	initialises the C229CAR_MASViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.c229_mas_left, view.c229_mas_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(C229CAR_MASViewAttribute *)firstViewAttribute;

/**
 *  Returns all C229CAR_MASViewConstraints installed with this view as a first item.
 *
 *  @param  view  A view to retrieve constraints for.
 *
 *  @return An array of C229CAR_MASViewConstraints.
 */
+ (NSArray *)installedConstraintsForView:(C229CAR_MAS_VIEW *)view;

@end
