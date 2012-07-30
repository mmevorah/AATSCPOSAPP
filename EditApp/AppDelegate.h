//
//  AppDelegate.h
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroundEditViewController;
@class EditManager;
@class IDManager;
@class FavoritesManager;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) GroundEditViewController *groundViewController;
@property (strong, nonatomic) IDManager *idManager;
@property (strong, nonatomic) FavoritesManager *favoritesManger;
@property (strong, nonatomic) EditManager *editManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end