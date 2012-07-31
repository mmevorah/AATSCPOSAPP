//
//  GroundViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 7/30/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "GroundEditViewController.h"
#import "EditManager.h"
#import "FavoritesManager.h"
#import "FavoriteList.h"
#import "Product.h"
#import <QuartzCore/QuartzCore.h>
#import "ModifyViewController.h"
#import "IDManager.h"
@interface GroundEditViewController ()

@end

@implementation GroundEditViewController

@synthesize editManager;
@synthesize segmentedControl;
@synthesize libraryView;
@synthesize productTableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    libraryView.layer.cornerRadius = 3;
    libraryView.layer.masksToBounds = YES;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[self packageSegmentedControllerArray]];
    CGPoint segmentedControlLocation = CGPointMake(self.view.center.x, self.view.frame.size.height - 75);
    self.segmentedControl.center = segmentedControlLocation;
    [self.view addSubview:self.segmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark preparingSegmentedController

-(NSArray*)packageSegmentedControllerArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"Library"];
    
    for(int i = 0; i < [[editManager numberOfActiveFavorites] intValue]; i++)
    {
        [array addObject:@"Favorite"];
    }
    if([[editManager numberOfActiveFavorites] intValue] == 0)
    {
        [array addObject:@"Favorite"];
        [array addObject:@"Favorite"];
    }
    
    return array;
}

- (void)viewDidUnload {
    [self setLibraryView:nil];
    [super viewDidUnload];
}

#pragma mark preparingLibraryView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[editManager getProductList]count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SegueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    UIFont *font = [UIFont fontWithName:@"Didot" size:25];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //name
    cell.textLabel.font = font;
    cell.textLabel.text = [[[editManager getProductList] objectAtIndex:[indexPath row]] name];
    
    //price
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = font;
    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[[[editManager getProductList]objectAtIndex:[indexPath row]]masterPrice]];
    
    //image
    if([[[editManager getProductList]objectAtIndex:[indexPath row]]image] == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"emptyImage.png"];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else
    {
        cell.imageView.image = [[[editManager getProductList] objectAtIndex:[indexPath row]]image];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return cell;
}

-(void)theSaveButtonHasBeenHit
{
    NSLog(@"So After saving the product list is: %@", [editManager getProductList]);
    [productTableView reloadData];
}

#pragma mark preparingForCreateProductView

- (IBAction)addButton:(UIBarButtonItem *)sender
{
    ModifyViewController *modifyViewController = [[ModifyViewController alloc] init];
    
    modifyViewController.editManager = self.editManager;

    modifyViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    modifyViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:modifyViewController animated:YES];
    modifyViewController.view.superview.frame = CGRectMake(0, 0, 500, 250);
    modifyViewController.view.superview.center = self.view.center;
    
    modifyViewController.titleBarTitle.text = @"Create Item";
    modifyViewController.saveButton.enabled = NO;
    modifyViewController.delegate = self;
}
@end
