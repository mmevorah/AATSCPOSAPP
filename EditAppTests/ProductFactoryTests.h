//
//  ProductFactoryTests.h
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class ProductFactory;
@class MockIDManager;
@interface ProductFactoryTests : SenTestCase
{
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectModel *model;
    NSManagedObjectContext *context;
    NSPersistentStore *store;
    
    MockIDManager *idManager;

    ProductFactory *productFactory;
}
@end
