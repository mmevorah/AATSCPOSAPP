//
//  VariationViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VariationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger variationCount;
}

@property (strong, nonatomic) IBOutlet UITableView *variationTableView;
@property (strong, nonatomic) IBOutlet UIStepper *addRemoveOutlet;

- (IBAction)itemBackButton:(UIBarButtonItem *)sender;
- (IBAction)addRemoveVariations:(UIStepper *)sender;


@end
