//
//  PurchaseManagerTests.h
//  EditApp
//
//  Created by Mark Mevorah on 8/21/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class PurchaseManager;
@class EditManager;
@class MockFavoritesManager;
@class MockIDManager;
@class Product;
@class Variation;

@interface PurchaseManagerTests : SenTestCase
{
    PurchaseManager *purchaseManager;
    
    EditManager *editManager;
    MockFavoritesManager *favoritesManager;
    MockIDManager *idManager;
    
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectModel *model;
    NSManagedObjectContext *context;
    NSPersistentStore *store;
    
    Product *product;
    Variation *variation;
}
@end
