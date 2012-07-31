//
//  EditViewControllerTests.m
//  EditApp
//
//  Created by Mark Mevorah on 7/24/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "EditViewControllerTests.h"
#import "EditViewController.h"
#import <objc/runtime.h>                    // need this to check properties
#import "ProductTableDataSource.h"

@implementation EditViewControllerTests
{
    EditViewController *editViewController;
    UITableView *tableView;
    id<UITableViewDelegate, UITableViewDataSource> dataSource;
}

-(void)setUp
{
    editViewController = [[EditViewController alloc] init];
    tableView = [[UITableView alloc] init];
    editViewController.tableView = tableView;
    dataSource = [[ProductTableDataSource alloc] init];
    editViewController.dataSource = dataSource;
}

-(void)tearDown
{
    editViewController = nil;
    tableView = nil;
    dataSource = nil;
}

-(void)testViewControllerHasATableViewProperty
{
    objc_property_t tableViewProperty = class_getProperty([editViewController class], "tableView"); //for runtime checking
    STAssertTrue(tableViewProperty != NULL, @"EditViewController needs a table property");
}

-(void)testViewControllerHasADataSourceProperty
{
    objc_property_t dataSourceProperty = class_getProperty([editViewController class], "dataSource");
    STAssertTrue(dataSourceProperty != NULL, @"EditViewController needs a data source");
}

-(void)testViewControllerConnectsDataSourceInViewDidLoad
{
    [editViewController viewDidLoad];
    STAssertEqualObjects([tableView dataSource], dataSource, @"EditViewController should have set the table view's data source");
}

-(void)testViewControllerConnectsDelegateInViewDidLoad
{
    [editViewController viewDidLoad];
    STAssertEqualObjects([tableView delegate], dataSource, @"EditViewController should have set the table view's delegate");
}

@end
