//
//  ProductFactoryTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ProductFactoryTests.h"
#import "ProductFactory.h"
#import "Product.h"

@implementation ProductFactoryTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
        
    productFactory = [[ProductFactory alloc] init];
    productFactory.context = context;
}

-(void)tearDown
{
    productFactory = nil;
    
    context = nil;
    NSError *error = nil;
    STAssertTrue([coordinator removePersistentStore:store error:&error],@"couldn't remove persistent store: %@", error);
    store = nil;
    coordinator = nil;
    model = nil;
}

-(void)testCreateANewProduct
{
    Product *newProduct = [productFactory createProductShell];
    STAssertNotNil(newProduct, @"The productFactory should be able to create a product");
}

@end
