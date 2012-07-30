//
//  IDManagerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "IDManagerTests.h"
#import "MockIDManager.h"

@implementation IDManagerTests

-(void)setUp
{
    idManager = [[MockIDManager alloc] init];
}

-(void)tearDown
{
    idManager = nil;
}


-(void)testContentsAreZeroAtStart
{
    STAssertTrue(([idManager.tempProductIDCount boolValue] | [idManager.tempVariantIDCount boolValue ] | [idManager.productIDCount boolValue] | [idManager.variantIDCount boolValue]) == 0, @"idManager Should start at zero");
}


-(void)testCanIncrementTempProductIDCount
{
    [idManager nextAvailableProductID];
    STAssertEquals([idManager.tempProductIDCount intValue], 1, @"idManager Should be able to increment the tempProductIDCount");
}

-(void)testCanIncrementTempVariantIDCount
{
    [idManager nextAvailableVariantID];
    STAssertEquals([idManager.tempVariantIDCount intValue], 1, @"idManager Should be able to increment the tempProductIDcount");
}

-(void)testNextAvailableProductID
{
    idManager.tempProductIDCount = [NSNumber numberWithInt:3];
    idManager.productIDCount = [NSNumber numberWithInt:5];
    STAssertEquals(idManager.nextAvailableProductID, [NSNumber numberWithInt: 8], @"The next avaialble product id method should return the next available id");
}

-(void)testNextAvailableVariantID
{
    idManager.tempVariantIDCount = [NSNumber numberWithInt:3];
    idManager.variantIDCount = [NSNumber numberWithInt:5];
    STAssertEquals(idManager.nextAvailableVariantID, [NSNumber numberWithInt: 8], @"The next available variant id should be returned upon calling this method");
}

//for saving
//for canceling

@end
