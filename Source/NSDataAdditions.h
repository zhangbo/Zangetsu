/*
//  NSDataAdditions.h
//  Zangetsu
//
//  Created by Colin Wheeler on 1/15/11.
//  Copyright 2012. All rights reserved.
//
 
 Copyright (c) 2012 Colin Wheeler
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Foundation/Foundation.h>


@interface NSData (CWNSDataAdditions)

/**
 Returns a NSString from the contents of the data encoded in UTF8 encoding
 
 @return a NSString from the contents of the NSData object, otherwise nil
 */
-(NSString *)cw_NSStringFromData;

/**
 Returns a const char from the contents of the NSData object encoded in UTF8
 
 @return a const char from the contents of the NSData object, otherwise nil
 */
-(const char *)cw_utf8StringFromData;

/**
 returns a string with the representation of the data in hex
 
 @return a NSString with the data representation in hex, otherwise nil
 */
-(NSString *)cw_hexString;

@end
