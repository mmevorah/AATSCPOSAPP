//
//  CartViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/28/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "CartViewController.h"
#import "PurchaseManager.h"
#import "Order.h"
#import "OrderItem.h"
#import "EditManager.h"
#import "Product.h"

@interface CartViewController ()

@end

@implementation CartViewController

@synthesize purchaseManager;
@synthesize cartItemTable;
@synthesize editManager;

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
}

-(void)viewDidAppear:(BOOL)animated
{
    [cartItemTable reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [purchaseManager.order.orderItem count];
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
    cell.textLabel.text =[[editManager productFromID:[[purchaseManager.order.orderItem.allObjects objectAtIndex:[indexPath row]] productID]] name] ;
        
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = font;
    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[[purchaseManager.order.orderItem.allObjects objectAtIndex:[indexPath row]] quantity]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCartItemTable:nil];
    [super viewDidUnload];
}
@end
