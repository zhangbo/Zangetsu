/*
//  CWSerialBlockQueue.m
//  Zangetsu
//
//  Created by Colin Wheeler on 2/23/12.
//  Copyright (c) 2012. All rights reserved.
//
 
 Copyright (c) 2011 Colin Wheeler
 
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

#import "CWSerialBlockQueue.h"

@interface CWSerialBlockOperation()
@property(nonatomic,copy) dispatch_block_t operationBlock;
@end

@implementation CWSerialBlockOperation

@synthesize operationBlock = _operationBlock;
@synthesize completionBlock = _completionBlock;

- (id)init
{
    self = [super init];
    if (self) {
        _operationBlock = NULL;
		_completionBlock = NULL;
    }
    return self;
}

+(CWSerialBlockOperation *)blockOperationWithBlock:(dispatch_block_t)block
{
	CWSerialBlockOperation *operation = [[CWSerialBlockOperation alloc] init];
	if (operation) {
		[operation setOperationBlock:block];
		return operation;
	}
	return nil;
}

@end

@interface CWSerialBlockQueue()
@property(nonatomic, assign) dispatch_queue_t queue;
@property(atomic,retain) CWQueue *blocksQueue;
@end

@implementation CWSerialBlockQueue

@synthesize blocksQueue = _blocksQueue;
@synthesize queue = _queue;

- (id)init
{
    self = [super init];
    if (self) {
        _blocksQueue = [[CWQueue alloc] init];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-"), DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

-(id)initWithBlockOperationObjects:(NSArray *)blockOperations 
{
	self = [super init];
	if (self) {
		_blocksQueue = [[CWQueue alloc] initWithObjectsFromArray:blockOperations];
		_queue = dispatch_queue_create(CWUUIDCStringPrependedWithString(@"com.Zangetsu.CWSerialBlockQueue-"), DISPATCH_QUEUE_SERIAL);
		for (CWSerialBlockOperation *op in blockOperations) {
			dispatch_async(_queue, ^{
				[op operationBlock]();
				if ([op completionBlock]) {
					[op completionBlock]();
				}
			});
		}
	}
	return self;
}

-(void)startProcessingBlocks
{
	dispatch_resume([self queue]);
}

-(void)stopProcessingBlocks
{
	dispatch_suspend([self queue]);
}

-(void)addOperationwithBlock:(dispatch_block_t)block
{
	dispatch_async([self queue], block);
}

-(void)waitUntilAllBlocksHaveProcessed
{
	dispatch_barrier_sync([self queue], ^{ });
}

-(void)executeWhenAllBlocksHaveFinished:(dispatch_block_t)block
{
	dispatch_barrier_async([self queue], block);
}

@end
