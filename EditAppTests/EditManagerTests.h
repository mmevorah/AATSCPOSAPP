//
//  EditManagerTests.h
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
@class EditManager;
@class MockIDManager;
@class MockFavoritesManager;
@class Product;
@class Variation;

@interface EditManagerTests : SenTestCase
{
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectModel *model;
    NSManagedObjectContext *context;
    NSPersistentStore *store;
    
    EditManager *editManager;
    MockIDManager *idManager;
    MockFavoritesManager *mockFavoritesManager;
    
    Product *product;
    
}
@end
