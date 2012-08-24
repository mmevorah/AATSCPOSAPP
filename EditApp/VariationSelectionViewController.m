//
//  VariationSelectionViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "VariationSelectionViewController.h"
#import "Product.h"
#import "EditManager.h"
#import "Variation.h"
@interface VariationSelectionViewController ()

@end

@implementation VariationSelectionViewController

@synthesize product;
@synthesize variationTable;
@synthesize editManager;
@synthesize delegate;

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
    self.contentSizeForViewInPopover = CGSizeMake(250, product.variation.count *55);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return product.variation.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TableFormatting
    static NSString *CellIdentifier = @"cell";
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = font;
    cell.textLabel.text = [[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] name];
    
    cell.detailTextLabel.font = font;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = font;
    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] price]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate addProductToCartWithID:product.iD andVariationID:[[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] iD]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setVariationTable:nil];
    [super viewDidUnload];
}
@end
