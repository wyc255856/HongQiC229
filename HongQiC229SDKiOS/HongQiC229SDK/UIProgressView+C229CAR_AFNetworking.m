// UIProgressView+C229CAR_AFNetworking.m
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

#import "UIProgressView+C229CAR_AFNetworking.h"

#import <objc/runtime.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import "C229CAR_AFURLSessionManager.h"

static void * C229CAR_AFTaskCountOfBytesSentContext = &C229CAR_AFTaskCountOfBytesSentContext;
static void * C229CAR_AFTaskCountOfBytesReceivedContext = &C229CAR_AFTaskCountOfBytesReceivedContext;

#pragma mark -

@implementation UIProgressView (C229CAR_AFNetworking)

- (BOOL)c229car_AF_uploadProgressAnimated {
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(c229car_AF_uploadProgressAnimated)) boolValue];
}

- (void)c229car_AF_setUploadProgressAnimated:(BOOL)animated {
    objc_setAssociatedObject(self, @selector(c229car_AF_uploadProgressAnimated), @(animated), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)c229car_AF_downloadProgressAnimated {
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(c229car_AF_downloadProgressAnimated)) boolValue];
}

- (void)c229car_AF_setDownloadProgressAnimated:(BOOL)animated {
    objc_setAssociatedObject(self, @selector(c229car_AF_downloadProgressAnimated), @(animated), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)setProgressWithUploadProgressOfTask:(NSURLSessionUploadTask *)task
                                   animated:(BOOL)animated
{
    [task addObserver:self forKeyPath:@"state" options:(NSKeyValueObservingOptions)0 context:C229CAR_AFTaskCountOfBytesSentContext];
    [task addObserver:self forKeyPath:@"countOfBytesSent" options:(NSKeyValueObservingOptions)0 context:C229CAR_AFTaskCountOfBytesSentContext];

    [self c229car_AF_setUploadProgressAnimated:animated];
}

- (void)setProgressWithDownloadProgressOfTask:(NSURLSessionDownloadTask *)task
                                     animated:(BOOL)animated
{
    [task addObserver:self forKeyPath:@"state" options:(NSKeyValueObservingOptions)0 context:C229CAR_AFTaskCountOfBytesReceivedContext];
    [task addObserver:self forKeyPath:@"countOfBytesReceived" options:(NSKeyValueObservingOptions)0 context:C229CAR_AFTaskCountOfBytesReceivedContext];

    [self c229car_AF_setDownloadProgressAnimated:animated];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(__unused NSDictionary *)change
                       context:(void *)context
{
    if (context == C229CAR_AFTaskCountOfBytesSentContext || context == C229CAR_AFTaskCountOfBytesReceivedContext) {
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesSent))]) {
            if ([object countOfBytesExpectedToSend] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setProgress:[object countOfBytesSent] / ([object countOfBytesExpectedToSend] * 1.0f) animated:self.c229car_AF_uploadProgressAnimated];
                });
            }
        }

        if ([keyPath isEqualToString:NSStringFromSelector(@selector(countOfBytesReceived))]) {
            if ([object countOfBytesExpectedToReceive] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setProgress:[object countOfBytesReceived] / ([object countOfBytesExpectedToReceive] * 1.0f) animated:self.c229car_AF_downloadProgressAnimated];
                });
            }
        }

        if ([keyPath isEqualToString:NSStringFromSelector(@selector(state))]) {
            if ([(NSURLSessionTask *)object state] == NSURLSessionTaskStateCompleted) {
                @try {
                    [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(state))];

                    if (context == C229CAR_AFTaskCountOfBytesSentContext) {
                        [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesSent))];
                    }

                    if (context == C229CAR_AFTaskCountOfBytesReceivedContext) {
                        [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(countOfBytesReceived))];
                    }
                }
                @catch (NSException * __unused exception) {}
            }
        }
    }
}

@end

#endif
