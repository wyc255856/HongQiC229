// C229CAR_AFNetworking.h
//
// Copyright (c) 2013 C229CAR_AFNetworking (http://afnetworking.com/)
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

#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _C229CAR_AFNETWORKING_
    #define _C229CAR_AFNETWORKING_

    #import "C229CAR_AFURLRequestSerialization.h"
    #import "C229CAR_AFURLResponseSerialization.h"
    #import "C229CAR_AFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "C229CAR_AFNetworkReachabilityManager.h"
#endif

    #import "C229CAR_AFURLSessionManager.h"
    #import "C229CAR_AFHTTPSessionManager.h"

#endif /* _C229CAR_AFNETWORKING_ */
