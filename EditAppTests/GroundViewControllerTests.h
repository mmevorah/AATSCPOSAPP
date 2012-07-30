//
//  GroundViewControllerTests.h
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@class GroundEditViewController;
@class EditManager;
@class MockIDManager;
@class MockFavoritesManager;
@interface GroundViewControllerTests : SenTestCase
{
    GroundEditViewController *groundViewController;
    EditManager *editManager;
    MockIDManager *idManager;
    MockFavoritesManager *favoritesManager;
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectModel *model;
    NSManagedObjectContext *context;
    NSPersistentStore *store;
}



@end
