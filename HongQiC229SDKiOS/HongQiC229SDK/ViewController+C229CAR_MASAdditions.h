//
//  UIViewController+C229CAR_MASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "C229CAR_MASUtilities.h"
#import "C229CAR_MASConstraintMaker.h"
#import "C229CAR_MASViewAttribute.h"

#ifdef C229CAR_MAS_VIEW_CONTROLLER

@interface C229CAR_MAS_VIEW_CONTROLLER (C229CAR_MASAdditions)

/**
 *	following properties return a new C229CAR_MASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_topLayoutGuide;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_bottomLayoutGuide;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_topLayoutGuideTop;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) C229CAR_MASViewAttribute *c229_mas_bottomLayoutGuideBottom;


@end

#endif
