//
//  ModifyViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditManager;
@class IDManager;
@class VariationViewController;
@class Product;
@class ModifyViewController;

@protocol ModifyViewControllerDelegate <NSObject>

-(void)theSaveButtonHasBeenHit;

@end

@interface ModifyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSString *lcuw;
    NSString *nameInField;
    NSNumber *priceInField;
    
}

@property (strong, nonatomic) id<ModifyViewControllerDelegate> delegate;
@property (strong, nonatomic) VariationViewController *variationViewController;

@property (strong, nonatomic)EditManager *editManager;
@property (strong, nonatomic)Product *product;

@property (strong, nonatomic) IBOutlet UILabel *titleBarTitle;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITableView *textFieldTable;
@property (strong, nonatomic) IBOutlet UIButton *disclosureButton;

- (IBAction) saveButton:(UIBarButtonItem *)sender;
- (IBAction) cancelButton:(UIBarButtonItem *)sender;
- (IBAction) disclosureButtonAction:(UIButton *)sender;

@end
