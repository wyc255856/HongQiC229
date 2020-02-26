//
//  C229CAR_MASUtilities.h
//  Masonry
//
//  Created by Jonas Budelmann on 19/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <Foundation/Foundation.h>



#if TARGET_OS_IPHONE || TARGET_OS_TV

    #import <UIKit/UIKit.h>
    #define C229CAR_MAS_VIEW UIView
    #define C229CAR_MAS_VIEW_CONTROLLER UIViewController
    #define C229CAR_MASEdgeInsets UIEdgeInsets

    typedef UILayoutPriority C229CAR_MASLayoutPriority;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityRequired = UILayoutPriorityRequired;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultMedium = 500;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel;

#elif TARGET_OS_MAC

    #import <AppKit/AppKit.h>
    #define C229CAR_MAS_VIEW NSView
    #define C229CAR_MASEdgeInsets NSEdgeInsets

    typedef NSLayoutPriority C229CAR_MASLayoutPriority;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityRequired = NSLayoutPriorityRequired;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultHigh = NSLayoutPriorityDefaultHigh;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDragThatCanResizeWindow = NSLayoutPriorityDragThatCanResizeWindow;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultMedium = 501;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityWindowSizeStayPut = NSLayoutPriorityWindowSizeStayPut;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDragThatCannotResizeWindow = NSLayoutPriorityDragThatCannotResizeWindow;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityDefaultLow = NSLayoutPriorityDefaultLow;
    static const C229CAR_MASLayoutPriority C229CAR_MASLayoutPriorityFittingSizeCompression = NSLayoutPriorityFittingSizeCompression;

#endif

/**
 *	Allows you to attach keys to objects matching the variable names passed.
 *
 *  view1.c229_mas_key = @"view1", view2.c229_mas_key = @"view2";
 *
 *  is equivalent to:
 *
 *  C229CAR_MASAttachKeys(view1, view2);
 */
#define C229CAR_MASAttachKeys(...)                                                        \
    {                                                                             \
        NSDictionary *keyPairs = NSDictionaryOfVariableBindings(__VA_ARGS__);     \
        for (id key in keyPairs.allKeys) {                                        \
            id obj = keyPairs[key];                                               \
            NSAssert([obj respondsToSelector:@selector(setMas_key:)],             \
                     @"Cannot attach c229_mas_key to %@", obj);                        \
            [obj setMas_key:key];                                                 \
        }                                                                         \
    }

/**
 *  Used to create object hashes
 *  Based on http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
 */
#define C229CAR_MAS_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define C229CAR_MAS_NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (C229CAR_MAS_NSUINT_BIT - howmuch)))

/**
 *  Given a scalar or struct value, wraps it in NSValue
 *  Based on EXPObjectify: https://github.com/specta/expecta
 */
static inline id _C229CAR_MASBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(C229CAR_MASEdgeInsets)) == 0) {
        C229CAR_MASEdgeInsets actual = (C229CAR_MASEdgeInsets)va_arg(v, C229CAR_MASEdgeInsets);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#define C229CAR_MASBoxValue(value) _C229CAR_MASBoxValue(@encode(__typeof__((value))), (value))
