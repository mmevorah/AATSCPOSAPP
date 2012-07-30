//
//  ProductTableDelegateTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/24/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ProductTableDelegateTests.h"
#import "ProductTableDataSource.h"
#import "Product.h"
#import "ProductFactory.h"

@implementation ProductTableDelegateTests
{
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    
    NSNotification *recievedNotification;
    ProductTableDataSource *dataSource;
    
  //  ProductTableDelegate *delegate;
    ProductFactory *productFactory;
    Product *product;
    
}

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
   // delegate = [[ProductTableDelegate alloc] init];
    dataSource = [[ProductTableDataSource alloc] init];
    productFactory = [[ProductFactory alloc] init];
    productFactory.context = context;
    product = [productFactory createProductWithTheName:@"Shirt" theImage:nil];
    [dataSource setProducts:[NSArray arrayWithObject: product]];
   // delegate.tableDataSource = dataSource;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:ProductTableDidSelectProductNotification object:nil];
}

-(void)tearDown
{
    recievedNotification = nil;
   // delegate = nil;
    dataSource = nil;
    productFactory = nil;
    product = nil;
    model = nil;
    coordinator = nil;
    store = nil;
    context = nil;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)didReceiveNotification:(NSNotification *)note
{
    recievedNotification = note;
}


-(void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected
{
    NSIndexPath *selection = [NSIndexPath indexPathForRow:0 inSection:0];
    [dataSource tableView:nil didSelectRowAtIndexPath:selection];
    STAssertEqualObjects([recievedNotification name], @"ProductTableDidSelectProductNotification", @"The delegate should notify that a topic was selected");
    STAssertEqualObjects([recievedNotification object], product, @"The notification should indicate which topic was selected");
}




@end
