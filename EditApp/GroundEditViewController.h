//
//  GroundViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditManager;

@interface GroundEditViewController : UIViewController

@property (strong, nonatomic)EditManager *editManager;
@property (strong, nonatomic)UISegmentedControl *segmentedControl;
@end
