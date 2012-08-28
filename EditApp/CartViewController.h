//
//  CartViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 8/28/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PurchaseManager;
@class EditManager;

@interface CartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PurchaseManager *purchaseManager;
@property (strong, nonatomic) EditManager *editManager;
@property (strong, nonatomic) IBOutlet UITableView *cartItemTable;

@end
