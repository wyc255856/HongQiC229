//
//  UIViewController+C229CAR_MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+C229CAR_MASAdditions.h"

#ifdef C229CAR_MAS_VIEW_CONTROLLER

@implementation C229CAR_MAS_VIEW_CONTROLLER (C229CAR_MASAdditions)

- (C229CAR_MASViewAttribute *)c229_mas_topLayoutGuide {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (C229CAR_MASViewAttribute *)c229_mas_topLayoutGuideTop {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (C229CAR_MASViewAttribute *)c229_mas_topLayoutGuideBottom {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (C229CAR_MASViewAttribute *)c229_mas_bottomLayoutGuide {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (C229CAR_MASViewAttribute *)c229_mas_bottomLayoutGuideTop {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (C229CAR_MASViewAttribute *)c229_mas_bottomLayoutGuideBottom {
    return [[C229CAR_MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
