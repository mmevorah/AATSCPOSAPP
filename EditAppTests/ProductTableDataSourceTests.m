//
//  ProductTableDataSourceTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/25/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ProductTableDataSourceTests.h"
#import "Product.h"
#import "ProductFactory.h"
#import "ProductTableDataSource.h"
@implementation ProductTableDataSourceTests
{
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    
    ProductFactory *factory;
    Product *product;
    NSArray *productList;
    ProductTableDataSource *dataSource;
}

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    factory = [[ProductFactory alloc] init];
    factory.context = context;
    dataSource = [[ProductTableDataSource alloc] init];
    product = [factory createProductWithTheName:@"Shirt" theImage:nil];
    productList = [NSArray arrayWithObject:product];
    [dataSource setProducts:productList];
}

-(void)tearDown
{
    context = nil;
    NSError *error = nil;
    STAssertTrue([coordinator removePersistentStore:store error:&error],@"couldn't remove persistent store: %@", error);
    store = nil;
    coordinator = nil;
    model = nil;
    
    dataSource = nil;
    factory = nil;
    product = nil;
    
}

-(void)testProductDataSourceCanRecieveAListOfProduct
{
    STAssertNoThrow([dataSource setProducts: productList], @"The data source needs a list of products");
}

-(void)testOneTableRowForOneProduct
{
    
    STAssertEquals((NSInteger)[productList count], [dataSource tableView:nil numberOfRowsInSection:0], @"As there's one topic, there should be one row in the table");
}

-(void)testTwoTableRowsForTwoProducts
{
    Product *product1 = [factory createProductWithTheName:@"Shirt" theImage:nil];
    Product *product2 = [factory createProductWithTheName:@"Sweater" theImage:nil];
    NSArray *twoProductsList = [NSArray arrayWithObjects:product1, product2, nil];
    [dataSource setProducts:twoProductsList];
    STAssertEquals((NSInteger)[twoProductsList count], [dataSource tableView:nil numberOfRowsInSection:0], @"There should be two rows in the table for two products");
}

-(void)testOneSectionInTheTableView
{
    STAssertThrows([dataSource tableView:nil numberOfRowsInSection:1], @"Data source doesn't allow asking about additional sections");
}

-(void)testDataSourceCellCreationExpectsOneSection
{
    NSIndexPath *secondSection = [NSIndexPath indexPathForRow:0 inSection:1];
    STAssertThrows([dataSource tableView:nil cellForRowAtIndexPath:secondSection], @"Data source will not prepare cells for unepected sections");
}

-(void)testDataSourceCellCreationWillNotCreateMoreRowsThanItHasProducts
{
    NSIndexPath *afterLastProduct = [NSIndexPath indexPathForRow:[productList count] inSection:0];
    STAssertThrows([dataSource tableView:nil cellForRowAtIndexPath:afterLastProduct], @"Data source will not prepare more cells than there are topics");
}

-(void)testCellCreatedByDataSourceContainsProductTitleAsTextLabel
{
    NSIndexPath *firstProduct = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *firstCell = [dataSource tableView:nil cellForRowAtIndexPath:firstProduct];
    NSString *cellTitle = firstCell.textLabel.text;
    STAssertEqualObjects(@"Shirt", cellTitle, @"Cell's title should be equal to the topic's title");
}

@end

