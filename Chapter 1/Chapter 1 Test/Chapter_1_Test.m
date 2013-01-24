//
//  Chapter_1_Test.m
//  Chapter 1 Test
//
//  Created by Ben Chen on 1/23/13.
//  Copyright (c) 2013 Sleeping Heroes. All rights reserved.
//

#import "AKRuntimeObject.h"
#import "AKCArray.h"

#import "Chapter_1_Test.h"

@implementation Chapter_1_Test

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testAddingMethod
{
	AKRuntimeObject *runtimeObject = [[AKRuntimeObject alloc] init];
	NSString *name = @"theName";
	STAssertNoThrow(runtimeObject.name = name, @"");
	STAssertEqualObjects(name, runtimeObject.name, @"");
}

- (void)testCArray
{
	AKCArray *cArray = [[AKCArray alloc] initWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18, nil];
	NSArray *array = [[NSArray alloc] initWithObjects:@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18, nil];
	NSUInteger idx = 0;
	for (id object in cArray) {
		STAssertEqualObjects(object, array[idx], @"they should equal");
		++idx;
	}
	
	cArray = [[AKCArray alloc] initWithObjects:[[NSObject alloc] init], nil];
	idx = 0;
	for (id object in cArray) {
		NSLog(@"object:%@", object);
		++idx;
	}
}

- (void)testCThrow
{
	AKCArray *cArray = [[AKCArray alloc] initWithObjects:@1,@2, nil];
	BOOL exeptionCatched = NO;
	@try {
		for (id object in cArray) {
			[cArray removeObject:object];
		}
	}
	@catch (NSException *exception) {
		exeptionCatched = YES;
	}
	@finally {
		STAssertTrue(exeptionCatched, @"An exception should have raised.");
	}
}

@end
