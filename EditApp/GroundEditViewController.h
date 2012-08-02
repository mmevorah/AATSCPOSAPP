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

@interface GroundEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ModifyViewControllerDelegate>

@property (strong, nonatomic)EditManager *editManager;
@property (strong, nonatomic)UISegmentedControl *segmentedControl;

//Library View
@property (strong, nonatomic) IBOutlet UIView *libraryView;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)addButton:(UIBarButtonItem *)sender;

@end
