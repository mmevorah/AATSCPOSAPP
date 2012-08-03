//
//  VariationViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VariationViewController;
@class EditManager;
@class Product;

@protocol VariationViewControllerDelegate <NSObject>

-(void)backButtonWasHit:(VariationViewController*)controller;

@end

@interface VariationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger variationCount;
}

@property (strong, nonatomic) id<VariationViewControllerDelegate>delegate;
@property (strong, nonatomic) EditManager *editManager;
@property (strong, nonatomic) Product *product;
@property (strong, nonatomic) IBOutlet UITableView *variationTableView;
@property (strong, nonatomic) UINavigationController *navigationController;

- (IBAction)itemBackButton:(UIBarButtonItem *)sender;
- (IBAction)addVariation:(UIBarButtonItem *)sender;


@end
