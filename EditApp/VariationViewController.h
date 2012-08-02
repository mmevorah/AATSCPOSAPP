//
//  VariationViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditManager;
@class Product;
@interface VariationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger variationCount;
}

@property (strong, nonatomic) EditManager *editManager;
@property (strong, nonatomic) Product *product;
@property (strong, nonatomic) IBOutlet UITableView *variationTableView;

- (IBAction)itemBackButton:(UIBarButtonItem *)sender;
- (IBAction)addVariation:(UIBarButtonItem *)sender;


@end
