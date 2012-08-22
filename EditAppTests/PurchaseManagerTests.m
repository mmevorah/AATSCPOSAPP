//
//  PurchaseManagerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 8/21/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "PurchaseManagerTests.h"
#import "PurchaseManager.h"
#import "Order.h"
#import "EditManager.h"
#import "MockIDManager.h"
#import "MockFavoritesManager.h"
#import "Product.h"
#import "OrderItem.h"
#import "Variation.h"

@implementation PurchaseManagerTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    idManager = [[MockIDManager alloc] init];
    favoritesManager = [[MockFavoritesManager alloc] init];
    editManager = [[EditManager alloc] initWithManagedObjectContext:context andIDManager:idManager];
    editManager.favoriteManager = favoritesManager;
    
    purchaseManager = [[PurchaseManager alloc] initWithEditManager:editManager];
    
    product = [editManager createProductShell];
    product.name = @"Shirt";
    variation = [[product.variation allObjects] objectAtIndex:0];
    variation.price = [NSNumber numberWithDouble:5.0];
    
    [purchaseManager createNewOrder];
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
}

-(void)tearDown
{
    model = nil;
    coordinator = nil;
    store = nil;
    context = nil;
    idManager = nil;
    favoritesManager = nil;
    editManager = nil;
    purchaseManager = nil;
    product = nil;
    variation = nil;
}

-(void)testPurchaseManagerExists
{
    STAssertNotNil(purchaseManager, @"Purchase Manager should be able to be created");
}

-(void)testPurchaseManagerIntegratesEditManager
{
    STAssertNotNil([purchaseManager getEditManager], @"PurchaseManager should be intialized with the edit manager");
}

-(void)testOrderCanBeCreated
{
    STAssertNotNil(purchaseManager.order, @"PurchaseManager should be able to create a new order");
}

-(void)testProductCanBeAddedToOrder
{
    STAssertTrue([[purchaseManager.order.orderItem allObjects] count] == 1, @"Should be able to add product to cart");
}

-(void)testAddingAProductToTheOrderUpdatesTheTotalPrice
{    
    STAssertTrue([purchaseManager.order.totalPrice doubleValue] == 5.0, @"Adding a product should update the total price of the cart");
}

-(void)testUpdateQuantityIfOrderItemAlreadyExists
{
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    STAssertTrue([[[[purchaseManager.order.orderItem allObjects] objectAtIndex:0] quantity] intValue] == 2, @"If an item is repeated, its quantity should update");
}

-(void)testUpdateTotalPriceIfOrderItemAlreadyExists
{
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    STAssertTrue([[purchaseManager.order totalPrice] doubleValue] == 10, @"If an item is repeated, the total price should be updated");
}

-(void)testRemovingItemWhenOnlyOneExists
{
    [purchaseManager removeProductWithID:product.iD andVariation:variation.iD];
    STAssertTrue([[purchaseManager.order.orderItem allObjects] count] == 0, @"removing a product with only one quantity should just remove it from the order");
    STAssertTrue([[purchaseManager.order totalPrice] doubleValue] == 0, @"removing the last product should leave the total price at 0");
}

-(void)testCanRemoveItemFromOrderAndItUpdatesQuantitiesAndTotalPrice
{
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    
    [purchaseManager removeProductWithID:product.iD andVariation:variation.iD];
    STAssertTrue([[purchaseManager.order totalPrice] doubleValue] == 15, @"At this point the total price should be 20");
    STAssertTrue([[[[purchaseManager.order.orderItem allObjects] objectAtIndex:0] quantity] intValue] == 3, @"at this point the item queantity should equal 4");
}

/*
-(void)testPlaceOrderNamesTheOrderTheTimeExecuted
{
    [purchaseManager placeOrder];
    STAssertNotNil(purchaseManager.order.name, @"Order should be names when the order is placed");
}
*/
 
-(void)testPlaceOrderCreatesANewOrderAfterCompletion
{
    [purchaseManager placeOrder];
    STAssertTrue([[[purchaseManager order] orderItem] count] == 0, @"After the order is placed, the paurchase manager should create a new order");
}

-(void)testOrderHistory
{
    [purchaseManager placeOrder];
    [purchaseManager addProductWithID:product.iD andVariation:variation.iD];
    [purchaseManager placeOrder];
    
    NSLog(@"order history: %@", [purchaseManager getOrderHistoryList]);
    STAssertTrue([[purchaseManager getOrderHistoryList] count] == 2, @"Order history list should update after orders complete");
}

@end

