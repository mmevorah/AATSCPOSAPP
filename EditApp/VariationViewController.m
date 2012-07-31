//
//  VariationViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "VariationViewController.h"

@interface VariationViewController ()

@end

@implementation VariationViewController
@synthesize variationTableView;
@synthesize addRemoveOutlet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    variationCount = 1; // change to 2
    addRemoveOutlet.value = variationCount;
    addRemoveOutlet.minimumValue = 1; //change to 2
    addRemoveOutlet.stepValue = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)itemBackButton:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)addRemoveVariations:(UIStepper *)sender {
    variationCount = sender.value;
    [variationTableView reloadData];
}

#pragma mark variationTableSetUp

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return variationCount;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SegueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 438, 44)];
    cell.accessoryView = cellView;
    UIView *columnView = [[UIView alloc] initWithFrame:CGRectMake(cellView.frame.size.width/2, 0, 1, cellView.frame.size.height)];
    columnView.backgroundColor = [UIColor grayColor];
    [cellView addSubview:columnView];
    return cell;
}

- (void)viewDidUnload {
    [self setVariationTableView:nil];
    [self setAddRemoveOutlet:nil];
    [super viewDidUnload];
}
@end
