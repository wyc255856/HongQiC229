// UIRefreshControl+C229CAR_AFNetworking.m
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIRefreshControl+C229CAR_AFNetworking.h"
#import <objc/runtime.h>

#if TARGET_OS_IOS

#import "C229CAR_AFURLSessionManager.h"

@interface C229CAR_AFRefreshControlNotificationObserver : NSObject
@property (readonly, nonatomic, weak) UIRefreshControl *refreshControl;
- (instancetype)initWithActivityRefreshControl:(UIRefreshControl *)refreshControl;

- (void)setRefreshingWithStateOfTask:(NSURLSessionTask *)task;

@end

@implementation UIRefreshControl (C229CAR_AFNetworking)

- (C229CAR_AFRefreshControlNotificationObserver *)c229car_AF_notificationObserver {
    C229CAR_AFRefreshControlNotificationObserver *notificationObserver = objc_getAssociatedObject(self, @selector(c229car_AF_notificationObserver));
    if (notificationObserver == nil) {
        notificationObserver = [[C229CAR_AFRefreshControlNotificationObserver alloc] initWithActivityRefreshControl:self];
        objc_setAssociatedObject(self, @selector(c229car_AF_notificationObserver), notificationObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return notificationObserver;
}

- (void)setRefreshingWithStateOfTask:(NSURLSessionTask *)task {
    [[self c229car_AF_notificationObserver] setRefreshingWithStateOfTask:task];
}

@end

@implementation C229CAR_AFRefreshControlNotificationObserver

- (instancetype)initWithActivityRefreshControl:(UIRefreshControl *)refreshControl
{
    self = [super init];
    if (self) {
        _refreshControl = refreshControl;
    }
    return self;
}

- (void)setRefreshingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidCompleteNotification object:nil];

    if (task) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreceiver-is-weak"
#pragma clang diagnostic ignored "-Warc-repeated-use-of-weak"
        if (task.state == NSURLSessionTaskStateRunning) {
            [self.refreshControl beginRefreshing];

            [notificationCenter addObserver:self selector:@selector(c229car_AF_beginRefreshing) name:C229CAR_AFNetworkingTaskDidResumeNotification object:task];
            [notificationCenter addObserver:self selector:@selector(c229car_AF_endRefreshing) name:C229CAR_AFNetworkingTaskDidCompleteNotification object:task];
            [notificationCenter addObserver:self selector:@selector(c229car_AF_endRefreshing) name:C229CAR_AFNetworkingTaskDidSuspendNotification object:task];
        } else {
            [self.refreshControl endRefreshing];
        }
#pragma clang diagnostic pop
    }
}

#pragma mark -

- (void)c229car_AF_beginRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreceiver-is-weak"
        [self.refreshControl beginRefreshing];
#pragma clang diagnostic pop
    });
}

- (void)c229car_AF_endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreceiver-is-weak"
        [self.refreshControl endRefreshing];
#pragma clang diagnostic pop
    });
}

#pragma mark -

- (void)dealloc {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidCompleteNotification object:nil];
    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:C229CAR_AFNetworkingTaskDidSuspendNotification object:nil];
}

@end

#endif
