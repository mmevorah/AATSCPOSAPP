//
//  GroundViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditManager.h"
#import "ModifyViewController.h"
@class EditManager;
@class ModifyViewController;
@class FavoritesView;
@class DragableView;

@interface GroundEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ModifyViewControllerDelegate>
{
    DragableView *dragableView;
}
@property (strong, nonatomic)EditManager *editManager;
@property (strong, nonatomic)UISegmentedControl *segmentedControl;

//Library View
@property (strong, nonatomic) IBOutlet UIView *libraryView;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)addButton:(UIBarButtonItem *)sender;

//Favorites View
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView0;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView1;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView2;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView3;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView4;

@end
