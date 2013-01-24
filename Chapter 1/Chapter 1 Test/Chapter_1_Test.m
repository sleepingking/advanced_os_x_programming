//
//  Chapter_1_Test.m
//  Chapter 1 Test
//
//  Created by Ben Chen on 1/23/13.
//  Copyright (c) 2013 Sleeping Heroes. All rights reserved.
//

#import "AKRuntimeObject.h"
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

@end
