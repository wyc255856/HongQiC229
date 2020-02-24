//
//  UIView+C229CAR_MASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+C229CAR_MASAdditions.h"

#ifdef C229CAR_MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'c229_mas_' prefixes,
 *  only enabled if C229CAR_MAS_SHORTHAND is defined
 */
@interface C229CAR_MAS_VIEW (C229CAR_MASShorthandAdditions)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *left;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *top;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *right;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *bottom;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *leading;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *trailing;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *width;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *height;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *centerX;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *centerY;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *baseline;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *firstBaseline;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *leftMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *rightMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *topMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *bottomMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *leadingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *trailingMargin;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *centerXWithinMargins;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

- (NSArray *)makeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;
- (NSArray *)updateConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;
- (NSArray *)remakeConstraints:(void(^)(C229CAR_MASConstraintMaker *make))block;

@end

#define C229CAR_MAS_ATTR_FORWARD(attr)  \
- (C229CAR_MASViewAttribute *)attr {    \
    return [self c229_mas_##attr];   \
}

@implementation C229CAR_MAS_VIEW (C229CAR_MASShorthandAdditions)

C229CAR_MAS_ATTR_FORWARD(top);
C229CAR_MAS_ATTR_FORWARD(left);
C229CAR_MAS_ATTR_FORWARD(bottom);
C229CAR_MAS_ATTR_FORWARD(right);
C229CAR_MAS_ATTR_FORWARD(leading);
C229CAR_MAS_ATTR_FORWARD(trailing);
C229CAR_MAS_ATTR_FORWARD(width);
C229CAR_MAS_ATTR_FORWARD(height);
C229CAR_MAS_ATTR_FORWARD(centerX);
C229CAR_MAS_ATTR_FORWARD(centerY);
C229CAR_MAS_ATTR_FORWARD(baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

C229CAR_MAS_ATTR_FORWARD(firstBaseline);
C229CAR_MAS_ATTR_FORWARD(lastBaseline);

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

C229CAR_MAS_ATTR_FORWARD(leftMargin);
C229CAR_MAS_ATTR_FORWARD(rightMargin);
C229CAR_MAS_ATTR_FORWARD(topMargin);
C229CAR_MAS_ATTR_FORWARD(bottomMargin);
C229CAR_MAS_ATTR_FORWARD(leadingMargin);
C229CAR_MAS_ATTR_FORWARD(trailingMargin);
C229CAR_MAS_ATTR_FORWARD(centerXWithinMargins);
C229CAR_MAS_ATTR_FORWARD(centerYWithinMargins);

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

C229CAR_MAS_ATTR_FORWARD(safeAreaLayoutGuideTop);
C229CAR_MAS_ATTR_FORWARD(safeAreaLayoutGuideBottom);
C229CAR_MAS_ATTR_FORWARD(safeAreaLayoutGuideLeft);
C229CAR_MAS_ATTR_FORWARD(safeAreaLayoutGuideRight);

#endif

- (C229CAR_MASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self c229_mas_attribute];
}

- (NSArray *)makeConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_makeConstraints:block];
}

- (NSArray *)updateConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_updateConstraints:block];
}

- (NSArray *)remakeConstraints:(void(NS_NOESCAPE ^)(C229CAR_MASConstraintMaker *))block {
    return [self c229_mas_remakeConstraints:block];
}

@end

#endif
