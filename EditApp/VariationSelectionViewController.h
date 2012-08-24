//
//  VariationSelectionViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 8/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@class EditManager;

@protocol VariationSelectionViewControllerDelegate <NSObject>

-(void)addProductToCartWithID:(NSNumber*)productID andVariationID:(NSNumber*)variationID;

@end

@interface VariationSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) id <VariationSelectionViewControllerDelegate> delegate;
@property (strong, nonatomic) Product *product;
@property (strong, nonatomic) EditManager *editManager;

@property (strong, nonatomic) IBOutlet UITableView *variationTable;


@end
