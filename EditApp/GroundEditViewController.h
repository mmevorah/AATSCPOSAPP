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
#import "VariationSelectionViewController.h"
@class EditManager;
@class ModifyViewController;
@class FavoritesView;
@class DragableView;
@class PurchaseManager;
@class VariationSelectionViewController;

@interface GroundEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, ModifyViewControllerDelegate, VariationSelectionViewControllerDelegate>
{
    DragableView *dragableView;
    CGPoint initialDragableViewLocation;
    NSArray *productList;
    NSString *productSearchText;
}


@property (strong, nonatomic) EditManager *editManager;
@property (strong, nonatomic) PurchaseManager *purchaseManager;

//Segment Control
@property (strong, nonatomic)UISegmentedControl *segmentedControl;

//Library View
@property (strong, nonatomic) IBOutlet UIView *libraryView;
@property (strong, nonatomic) IBOutlet UINavigationBar *titleBar;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)addButton:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButtonAppearance;
- (IBAction)editingComplete:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *editingCompleteButtonAppearance;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UIPopoverController *popOverController;
@property (strong, nonatomic) VariationSelectionViewController *variationSelectionViewController;

//Favorites View
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView0;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView1;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView2;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView3;
@property (strong, nonatomic) IBOutlet FavoritesView *favoritesView4;

@property (strong, nonatomic) IBOutlet UIButton *cartButton;
- (IBAction)cartButton:(UIButton *)sender;

@end
