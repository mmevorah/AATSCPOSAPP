//
//  GroundViewControllerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "GroundViewControllerTests.h"
#import "GroundEditViewController.h"
#import "EditManager.h"
#import "MockIDManager.h"
#import "MockFavoritesManager.h"
#import <objc/runtime.h>

@implementation GroundViewControllerTests

-(void)setUp
{
    model = [NSManagedObjectModel mergedModelFromBundles:nil];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:NULL];
    context = [[NSManagedObjectContext alloc] init ];
    [context setPersistentStoreCoordinator:coordinator];
    
    idManager = [[MockIDManager alloc] init];
    editManager = [[EditManager alloc] initWithManagedObjectContext:context andIDManager:idManager];
    favoritesManager = [[MockFavoritesManager alloc] init];
    editManager.favoriteManager = favoritesManager;
    
    groundViewController = [[GroundEditViewController alloc] init];
    groundViewController.editManager = editManager;
}

-(void)tearDown
{
    model = nil;
    coordinator = nil;
    store = nil;
    context = nil;
    
    idManager = nil;
    editManager = nil;
    favoritesManager = nil;
    
    groundViewController = nil;
}

-(void)testGroundViewControllerHasEditManagerProperty
{
    objc_property_t editManagerProperty = class_getProperty([groundViewController class], "editManager");
    STAssertTrue(editManagerProperty != NULL, @"edit manager property should exist in the ground view controller");
}

-(void)testSegmentedControllerInitializedProperly
{
    [groundViewController viewDidLoad];
    STAssertTrue(groundViewController.segmentedControl.numberOfSegments == 3, @"for an program with no favorites, the segmented controller should start off with two segments");
}



@end
