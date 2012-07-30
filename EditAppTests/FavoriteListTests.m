//
//  FavoriteListTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "FavoriteListTests.h"
#import "FavoriteList.h"

@implementation FavoriteListTests

-(void)setUp
{
    favList = [[FavoriteList alloc] init];
}

-(void)tearDown
{
    favList = nil;
}

-(void)testFavoriteListCanBeCreated
{
    STAssertNotNil(favList, @"Should be able to create a favorites list");
}

-(void)testCapacityIs25
{
    STAssertEquals(favList.size, 25, @"Size of list should be 25");
}

-(void)testCanAddObjectAtPosition
{
    NSNumber *productID = [[NSNumber alloc] initWithInt:23];
    [favList addProductWithID:productID toPosition:5];
    STAssertEquals([[favList.list objectAtIndex:5] intValue], [productID intValue], @"Should be able to add productId to favorites array");
}

-(void)testCanNotReplaceAnObjectOnListThats
{
    NSNumber *productID1 = [[NSNumber alloc] initWithInt:23];
    [favList addProductWithID:productID1 toPosition:5];
    NSNumber *productID2 = [[NSNumber alloc] initWithInt:14];
    [favList addProductWithID:productID2 toPosition:5];
    STAssertEquals([[favList.list objectAtIndex:5] intValue], 23, @"Should not be able to replace an object already in a poisiton");
}

-(void)testCanClearAPosition
{
    NSNumber *productID = [[NSNumber alloc] initWithInt:12];
    [favList addProductWithID:productID toPosition:5];
    [favList clearProductAtPosition:5];
    STAssertEquals([[favList.list objectAtIndex:5]intValue], -1,    @"Should be able to clear objects");
}

-(void)testDefaultIsHidden
{
    STAssertEquals([favList hidden], YES, @"Hidden should default to true");
}


@end
