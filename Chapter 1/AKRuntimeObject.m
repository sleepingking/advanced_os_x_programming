//
//  AKRuntimeObject.m
//  Advanced OS X Programming
//
//  Created by Ben Chen on 1/23/13.
//  Copyright (c) 2013 Sleeping Heroes. All rights reserved.
//

#import <objc/runtime.h>
#import "AKRuntimeObject.h"

@interface AKRuntimeObject ()
{
@public
	NSString *_name;
}
@end

static NSString *AKStringGetter(AKRuntimeObject *self, SEL selector)
{
	return self->_name;
}

static void AKStringSetter(AKRuntimeObject *self, SEL selector, id object)
{
	self->_name = (NSString *)[object copy];
}

@implementation AKRuntimeObject

@dynamic name;

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(name)) {
		class_addMethod([self class], sel, (IMP)AKStringGetter, "@@:");
		return YES;
    }
	else if (sel == @selector(setName:)) {
		class_addMethod([self class], sel, (IMP)AKStringSetter, "v@:@");
		return YES;
	}
    return [super resolveInstanceMethod:sel];
}

@end
