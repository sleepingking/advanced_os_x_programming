//
//  AKCArray.m
//  Advanced OS X Programming
//
//  Created by Ben Chen on 1/23/13.
//  Copyright (c) 2013 Sleeping Heroes. All rights reserved.
//

#import <objc/runtime.h>
#import "AKCArray.h"

@implementation AKCArray
{
	id __strong *_objects;
	NSUInteger _objectCount;
	unsigned long _mutations;
}

- (id)initWithObjects:(id)firstObject, ...
{
	self = [super init];
	if (self) {
		va_list args;
		
		// figure out the count
		va_start(args, firstObject);
		id object = firstObject;
		while (object != nil) {
			_objectCount++;
			object = va_arg(args, id);
		}
		va_end(args);
		
		// add the objects to the array
		if (_objectCount) {
			va_start(args, firstObject);
			
			void *ptrArray = malloc(sizeof(id) * _objectCount);
			bzero(ptrArray, sizeof(id) * _objectCount); // this is important, as otherwise runtime will think the array is not empty and try to call release on randam address when trying to add object to it.
			
			_objects = (id __strong*)ptrArray;
			object = firstObject;
			NSUInteger idx = 0;
			while (object != nil) {
				_objects[idx] = object;
				object = va_arg(args, id);
				++idx;
			}
			va_end(args);
		}
	}
	return self;
}

- (void)removeObject:(id)object
{
	if (_objectCount == 0)
		return;
	
	NSUInteger i;
	for (i = 0; i < _objectCount; ++i) {
		if (_objects[i] == object)
			break;
	}
	
	for  (; i+1 < _objectCount; ++i) {
		_objects[i] = _objects[i+1];
	}
	
	_objects[i] = nil;
	_objectCount--;
	_mutations++; // indicates the change
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
								  objects:(__unsafe_unretained id [])buffer
									count:(NSUInteger)len
{
	if (state->state == 0) {
		state->state = 1;
		state->mutationsPtr = &_mutations;
	}
	
	NSUInteger count = state->extra[0];
	if (count == _objectCount) {
		return 0;
	}
	else {
		NSUInteger idx = 0;
		while (idx < len && (idx + count) < _objectCount) {
			buffer[idx] = _objects[idx + count]; // fill the buffer
			++idx;
		}
		
		count += idx;
		
		state->extra[0] = count;
		state->itemsPtr = buffer;
		
		return idx;
	}
}

@end
