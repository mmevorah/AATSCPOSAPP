//
//  FavoritesManagerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "FavoritesManagerTests.h"
#import "MockFavoritesManager.h"
#import "FavoriteList.h"

@implementation FavoritesManagerTests

-(void)setUp
{
    favoritesManager = [[MockFavoritesManager alloc] init];
}

-(void)tearDown
{
    favoritesManager = nil;
}

-(void)testFavoritesManagerCanBeCreated
{
    STAssertNotNil(favoritesManager, @"Should be able to create a favoritesManager");
}

-(void)testCreated5FavoriteLists
{
    STAssertNotNil(favoritesManager.favList0, @"Can create Favorite List 0");
    STAssertNotNil(favoritesManager.favList1, @"Can create Favorite List 1");
    STAssertNotNil(favoritesManager.favList2, @"Can create Favorite List 2");
    STAssertNotNil(favoritesManager.favList3, @"Can create Favorite List 3");
    STAssertNotNil(favoritesManager.favList4, @"Can create Favorite List 4");
}

-(void)testAddProductToSpecificPositions
{
    [favoritesManager insertProductWithID:[NSNumber numberWithInt:4] intoFavoritesList:0 atPosition:23];
    STAssertEquals([[favoritesManager.favList0.list objectAtIndex:23] intValue], 4, @"Should Be Able to add product to specific positions in favorite lists from manager");
}

-(void)testClearProductAtSpecificPosition
{
    [favoritesManager insertProductWithID:[NSNumber numberWithInt:4] intoFavoritesList:0 atPosition:23];
    [favoritesManager removeProductFromList:0 atPostion:23];
    STAssertEquals([[favoritesManager.favList0.list objectAtIndex:23] intValue], -1, @"Should be able to clear product on list at a specific position");
}

@end
