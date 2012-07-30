//
//  VariationFactoryTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "VariationFactoryTests.h"
#import "VariationFactory.h"
#import "Variation.h"
@implementation VariationFactoryTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    variationFactory = [[VariationFactory alloc] init];
    variationFactory.context = context;
}

-(void)tearDown
{
    variationFactory = nil;
    
    context = nil;
    NSError *error = nil;
    STAssertTrue([coordinator removePersistentStore:store error:&error],@"couldn't remove persistent store: %@", error);
    store = nil;
    coordinator = nil;
    model = nil;
}

-(void)testVariationCanBeCreated
{
    Variation *newVariation = [variationFactory createVariationWithTheName:@"Regular" thePrice:[NSNumber numberWithDouble:3.5]   andIsItTheMaster:YES];
    STAssertNotNil(newVariation, @"Variation should be able to be created");
}

-(void)testVariationCanHaveItsNameSet
{
    Variation *newVariation = [variationFactory createVariationWithTheName:@"Regular" thePrice:[NSNumber numberWithDouble:3.5] andIsItTheMaster:NO];
    STAssertEquals(newVariation.name, @"Regular", @"Should be able to access created variation name");
}

-(void)testVariationCanHaveMasterSet
{
    Variation *newVariation = [variationFactory createVariationWithTheName:@"Regular" thePrice:[NSNumber numberWithDouble:3.5] andIsItTheMaster:YES];
    STAssertEquals([newVariation.master boolValue], YES, @"Should be able to access created variation name");
}

-(void)testVariationCanHavePriceSet
{
    Variation *newVariation = [variationFactory createVariationWithTheName:@"Regular" thePrice:[NSNumber numberWithDouble:3.5] andIsItTheMaster:NO];
    STAssertEquals([newVariation.price doubleValue], 3.5, @"Should be able to access created variation name");
}


@end
