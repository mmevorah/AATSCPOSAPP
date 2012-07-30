//
//  EditManagerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "EditManagerTests.h"
#import "EditManager.h"
#import "MockIDManager.h"
#import "MockFavoritesManager.h"
#import "FavoriteList.h"
#import "Product.h"
#import "Variation.h"
@implementation EditManagerTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    idManager = [[MockIDManager alloc] init];
    idManager.productIDCount = [NSNumber numberWithInt: 5];
    idManager.tempProductIDCount = [NSNumber numberWithInt:3];
    idManager.variantIDCount = [NSNumber numberWithInt: 1];
    idManager.tempVariantIDCount = [NSNumber numberWithInt:2];
    
    mockFavoritesManager = [[MockFavoritesManager alloc] init];
    
    editManager = [[EditManager alloc] initWithManagedObjectContext:context andIDManager:idManager];
    editManager.favoriteManager = mockFavoritesManager;
    
    product = [editManager createProductWithAName: @"Shirt" anImage: nil andAPrice: [NSNumber numberWithDouble:3.50]];
    
}

-(void)tearDown
{
    model = nil;
    coordinator = nil;
    store = nil;
    context = nil;
    idManager = nil;
    mockFavoritesManager = nil;
    editManager = nil;
    product = nil;
}

-(void)testEditManagerCreated
{
    STAssertNotNil(editManager, @"Edit manager should be successfully created");
}

-(void)testEditManageCanCreateAProduct
{    
    STAssertNotNil(product, @"Product should be able to be created from the editManager");
}


 -(void)testProductCreatesAVariationWhenCreated
 {
     STAssertTrue(product.variation.count > 0, @"Creating a new product creates a new single variation as well");
 }


 -(void)testFirstCreatedVariationStartsWithRegularName
 {
     STAssertEquals([[product.variation.allObjects objectAtIndex: 0] name], @"Regular", @"First product variation should be named regular");
 }
 
 -(void)testProductSetsMasterAtCreation
 {
     STAssertEquals([[[product.variation.allObjects objectAtIndex:0] master] boolValue], [[NSNumber numberWithBool:YES] boolValue], @"A Product created should set the first variation to master");
 }

-(void)testProductCanSetPrice
 {
     STAssertEquals([[[product.variation.allObjects objectAtIndex:0] price] doubleValue], [[NSNumber numberWithDouble:3.5] doubleValue], @"Product should be able to set the price of product");
 }
 
 -(void)testCanAccessProductPriceThroughMasterPriceMethod
 {
     STAssertEquals([product.masterPrice doubleValue], [[NSNumber numberWithDouble:3.50] doubleValue], @"Should be able to access the gneeral prce through master price method");
 }


-(void)testCanSetProductID
{
    STAssertEquals([product.iD intValue], 8, @"ID should be able to be set appropriately");
}

-(void)testCanSetVariantID
{
    NSLog(@"variation stuff: %@", [product.variation.allObjects objectAtIndex:0]);
    
    STAssertEquals([[[product.variation.allObjects objectAtIndex:0] iD] intValue], 3, @"ID should be able to set appropriately");
}


-(void)testProductIDIncrementedAfterCreation
{
    STAssertEquals([idManager.nextAvailableProductID intValue], 9, @"tempProductIDCount Should Increment after a product is created");
}

-(void)testVariantIDIncrementedAfterCreation
{
    STAssertEquals([idManager.nextAvailableVariantID intValue], 4, @"tempVariantIDCount should increment after a variation has been created");
}

#pragma mark Adding/Deleting Variations

-(void)testCanAddANewVariation
{
    [editManager addVariationToProduct:product withName:@"Small" andPrice:[NSNumber numberWithDouble: 5.0]];
    STAssertTrue(product.variation.allObjects.count == 2, @"Should be able to add a variation");
}

-(void)testCanDeleteAVariation
{
    [editManager addVariationToProduct:product withName:@"Small" andPrice: [NSNumber numberWithDouble: 5.0]];
    [editManager deleteVariation:[product.variation.allObjects objectAtIndex:1] inProduct:product];
    STAssertTrue(product.variation.count == 1, @"Should be able to delete a variation");
}

-(void)testProductNeedsAtLeastOneVariation
{
    [editManager deleteVariation:[product.variation.allObjects objectAtIndex:0] inProduct:product];
    STAssertTrue(product.variation.count > 0, @"Product needs at least one variation");
}

-(void)testIfMasterDeletedChangeTheNextVariationInLineToMaster
{
    [editManager addVariationToProduct:product withName:@"Small" andPrice:[NSNumber numberWithDouble:5.0]];
    [editManager deleteVariation:[product.variation.allObjects objectAtIndex:0]  inProduct:product];
    NSLog(@"next master object: %@", product.variation.allObjects);
    STAssertEquals([[[product.variation.allObjects objectAtIndex:0] master] boolValue], YES, @"Next variation in line should become master if the master variaiton is deleted");
}

-(void)testProductChangeName
{
    [editManager changeProduct:product nameTo:@"Mug"];
    STAssertEquals(product.name, @"Mug", @"Product name should be able to be changed");
}

-(void)testProductChangeImage
{
    UIImage *image = [[UIImage alloc] init];
    [editManager changeProduct:product imageTo:image];
    STAssertEquals(product.image, image, @"Product image should be able to be changed");
}

-(void)testVariationChangeName
{
    [editManager changeVariation:[product.variation.allObjects objectAtIndex:0] nameTo:@"Large"];
    STAssertEquals([[product.variation.allObjects objectAtIndex:0] name], @"Large", @"Variation name should beable to be changed");
}

-(void)testVariationChangePrice
{
    [editManager changeVariation:[product.variation.allObjects objectAtIndex:0] priceTo:[NSNumber numberWithDouble:3.3]];
    STAssertEquals([[[product.variation.allObjects objectAtIndex:0] price] doubleValue], 3.3, @"Variation price should be able to be changed");
}

-(void)testCanAddProductToFavorites
{
    [editManager addProductToFavoritesWithID:product.iD toFavoritesList:0 atPosition:[NSNumber numberWithInt:12]];
    STAssertEquals([[editManager.favoriteManager.favList0.list objectAtIndex:12] intValue] , [product.iD intValue], @"Edit manager can add favorites");
}

-(void)testCanRemoveProductFromAFavoritesList
{
    [editManager addProductToFavoritesWithID:product.iD toFavoritesList:0 atPosition:[NSNumber numberWithInt:23]];
    [editManager removeProductFromFavoritesList:0 position: [NSNumber numberWithInt: 23]];
    STAssertEquals([[editManager.favoriteManager.favList0.list objectAtIndex:23] intValue], -1, @"Edit manager should be able to remove products from favorites");
}

-(void)testCanReturnArrayOfProducts
{
    [editManager createProductWithAName:@"Pants" anImage:nil andAPrice:[NSNumber numberWithDouble: 4.5]];
    STAssertTrue([[editManager getProductList] count] == 2, @"edit manager should be able to return a list of products in the current context");
}

-(void)testReturnedArrayIsSortedByName
{
    [editManager createProductWithAName:@"Apple" anImage:nil andAPrice:[NSNumber numberWithDouble:3.50]];
    [editManager createProductWithAName:@"Zebra" anImage:nil andAPrice:[NSNumber numberWithDouble:4.60]];
    NSLog(@"list looks like: %@", [editManager getProductList]);
    STAssertTrue([[[[editManager getProductList] objectAtIndex:0] name] isEqualToString:@"Apple"], @"Apple should be first");
    STAssertTrue([[[[editManager getProductList] objectAtIndex:1] name] isEqualToString:@"Shirt"], @"Shirt should be second");
    STAssertTrue([[[[editManager getProductList] objectAtIndex:2] name] isEqualToString:@"Zebra"], @"Zebra should be third");
}


@end
