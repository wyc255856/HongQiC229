//
//  C229CAR_MASConstraint+Private.h
//  Masonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "C229CAR_MASConstraint.h"

@protocol C229CAR_MASConstraintDelegate;


@interface C229CAR_MASConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually C229CAR_MASConstraintMaker but could be a parent C229CAR_MASConstraint
 */
@property (nonatomic, weak) id<C229CAR_MASConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with C229CAR_MASEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface C229CAR_MASConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    C229CAR_MASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (C229CAR_MASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (C229CAR_MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol C229CAR_MASConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A C229CAR_MASViewConstraint may turn into a C229CAR_MASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(C229CAR_MASConstraint *)constraint shouldBeReplacedWithConstraint:(C229CAR_MASConstraint *)replacementConstraint;

- (C229CAR_MASConstraint *)constraint:(C229CAR_MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end
