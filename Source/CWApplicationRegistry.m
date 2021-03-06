/*
//  CWApplicationRegistry.m
//  Zangetsu
//
//  Created by Colin Wheeler on 5/15/11.
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

#import "CWApplicationRegistry.h"


@implementation CWApplicationRegistry


+(BOOL)applicationIsRunning:(NSString *)appName {
	BOOL isRunning = NO;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	isRunning = [applications cw_isObjectInArrayWithBlock:^BOOL(id obj) {
		if ([[obj localizedName] isEqualToString:appName]) return YES;
		return NO;
	}];
	return isRunning;
}

+(NSInteger)pidForApplication:(NSString *)appName {
	__block NSInteger pid = kPidNotFound;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			pid = [app processIdentifier];
			*stop = YES;
		}
	}];
	return pid;
}

+(NSString *)bundleIdentifierForApplication:(NSString *)appName {
	__block NSString *bundleIdentifier = nil;
	NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			bundleIdentifier = [app bundleIdentifier];
			*stop = YES;
		}
	}];
	return bundleIdentifier;
}

+(NSRunningApplication *)runningAppInstanceForApp:(NSString *)appName {
    __block NSRunningApplication *appInstance = nil;
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		if ([[app localizedName] isEqualToString:appName]) {
			appInstance = app;
			*stop = YES;
		}
	}];
    return appInstance;
}

+(NSImage *)iconForApplication:(NSString *)appName {
    __block NSImage *appIcon = nil;
    NSArray *applications = [[NSWorkspace sharedWorkspace] runningApplications];
	[applications cw_each:^(id obj, NSUInteger index, BOOL *stop) {
		NSRunningApplication *app = (NSRunningApplication *)obj;
		
		if ([[app localizedName] isEqualToString:appName]) {
			appIcon = [app icon];
			*stop = YES;
		}
	}];
    return appIcon;
}

@end
