//
//  EditViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 7/24/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController

@property(strong) UITableView *tableView;
@property(strong) id<UITableViewDataSource, UITableViewDelegate> dataSource;




@end
