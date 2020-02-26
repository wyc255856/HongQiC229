//
//  C229CAR_MASCompositeConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "C229CAR_MASConstraint.h"
#import "C229CAR_MASUtilities.h"

/**
 *	A group of C229CAR_MASConstraint objects
 */
@interface C229CAR_MASCompositeConstraint : C229CAR_MASConstraint

/**
 *	Creates a composite with a predefined array of children
 *
 *	@param	children	child C229CAR_MASConstraints
 *
 *	@return	a composite constraint
 */
- (id)initWithChildren:(NSArray *)children;

@end
