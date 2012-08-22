//
//  CoreDataTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "CoreDataTests.h"

#import "Product.h"
#import "Variation.h"

@implementation CoreDataTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    product = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
    variation = [NSEntityDescription insertNewObjectForEntityForName:@"Variation" inManagedObjectContext:context];

}

-(void)tearDown
{
    context = nil;
    NSError *error = nil;
    STAssertTrue([coordinator removePersistentStore:store error:&error],@"couldn't remove persistent store: %@", error);
    store = nil;
    coordinator = nil;
    model = nil;
}

-(void)testThatEnvironmentWorks
{
    STAssertNotNil(store, @"no persistent store");
}

#pragma mark productTests

-(void)testProductExists
{
    STAssertNotNil(product, @"A product should be able to be created");
}

-(void)testProductCanBeNamed
{
    product.name = @"Shirt";
    STAssertEquals([product name], @"Shirt", @"Product can be named");
}

-(void)testProductCanHaveAnAssociatedImage
{
    UIImage *testImage = [[UIImage alloc] init];
    product.image = testImage;
    STAssertNotNil([product image],@"A product can be assigned an image");
}

-(void)testProductCanBeIDd
{
    NSNumber *ID = [[NSNumber alloc] initWithInt:2];
    product.iD = ID;
    STAssertEquals([product iD], ID, @"Product can be ID'd");
}

#pragma mark variationTests

-(void)testVariationExists
{
    STAssertNotNil(variation, @"A variation should be able to be created");
}

-(void)testVariationCanBeNamed
{
    variation.name = @"Regular";
    STAssertEquals([variation name], @"Regular", @"Variaiton Should be able to be named");
}

-(void)testVariationCanHaveASetPrice
{
    NSNumber *price = [[NSNumber alloc] initWithDouble:3.50];
    variation.price = price;
    STAssertTrue([[variation price] isEqualToNumber: price], @"Variations should be able to be priced");
}

-(void)testVariationCanBeIDd
{
    NSNumber *ID = [[NSNumber alloc] initWithInt:4];
    variation.iD = ID;
    STAssertEquals([variation iD], ID, @"Variations van be ID'd");
}

/* THIS WHOLE TEST ISNT ESPECIALLY NECESSARY CONSIDERING I DIDNT HAVE TO WRITE THE CODE FOR THE METHOD*/

@end
