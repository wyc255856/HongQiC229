//
//  NSArray+C229CAR_MASAdditions.h
//
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "C229CAR_MASUtilities.h"
#import "C229CAR_MASConstraintMaker.h"
#import "C229CAR_MASViewAttribute.h"

typedef NS_ENUM(NSUInteger, C229CAR_MASAxisType) {
    C229CAR_MASAxisTypeHorizontal,
    C229CAR_MASAxisTypeVertical
};

@interface NSArray (C229CAR_MASAdditions)

/**
 *  Creates a C229CAR_MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing on each view
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_makeConstraints:(void (NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

/**
 *  Creates a C229CAR_MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_updateConstraints:(void (NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

/**
 *  Creates a C229CAR_MASConstraintMaker with each view in the callee.
 *  Any constraints defined are added to each view or the appropriate superview once the block has finished executing on each view.
 *  All constraints previously installed for the views will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to each view.
 *
 *  @return Array of created/updated C229CAR_MASConstraints
 */
- (NSArray *)c229_mas_remakeConstraints:(void (NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *make))block;

/**
 *  distribute with fixed spacing
 *
 *  @param axisType     which axis to distribute items along
 *  @param fixedSpacing the spacing between each item
 *  @param leadSpacing  the spacing before the first item and the container
 *  @param tailSpacing  the spacing after the last item and the container
 */
- (void)c229_mas_distributeViewsAlongAxis:(C229CAR_MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

/**
 *  distribute with fixed item size
 *
 *  @param axisType        which axis to distribute items along
 *  @param fixedItemLength the fixed length of each item
 *  @param leadSpacing     the spacing before the first item and the container
 *  @param tailSpacing     the spacing after the last item and the container
 */
- (void)c229_mas_distributeViewsAlongAxis:(C229CAR_MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end
