//
//  AKCArray.h
//  Advanced OS X Programming
//
//  Created by Ben Chen on 1/23/13.
//  Copyright (c) 2013 Sleeping Heroes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKCArray : NSObject <NSFastEnumeration>

- (id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

- (void)removeObject:(id)object;

@end
