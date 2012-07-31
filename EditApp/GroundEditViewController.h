//
//  GroundViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditManager;
@class LibraryViewController;
@interface GroundEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)EditManager *editManager;
@property (strong, nonatomic)UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIView *libraryView;

//Library View
@property (strong, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)addButton:(UIBarButtonItem *)sender;

@end
