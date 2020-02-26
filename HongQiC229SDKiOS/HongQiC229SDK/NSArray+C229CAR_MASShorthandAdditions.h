//
//  NSArray+C229CAR_MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+C229CAR_MASAdditions.h"

#ifdef C229CAR_MAS_SHORTHAND

/**
 *	Shorthand array additions without the 'c229_mas_' prefixes,
 *  only enabled if C229CAR_MAS_SHORTHAND is defined
 */
@interface NSArray (C229CAR_MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;

@end

@implementation NSArray (C229CAR_MASShorthandAdditions)

- (NSArray *)makeConstraints:(void(^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_remakeConstraints:block];
}

@end

#endif
