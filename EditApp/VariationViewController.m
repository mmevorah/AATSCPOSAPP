//
//  VariationViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "VariationViewController.h"
#import "EditManager.h"
#import "Product.h"
#import "Variation.h"

@interface VariationViewController ()

@end

@implementation VariationViewController
@synthesize variationTableView;
@synthesize editManager;
@synthesize product;
@synthesize delegate;

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
    variationCount = [[product variation] count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)itemBackButton:(UIBarButtonItem *)sender {
    //[editManager cleanUpVariationListForProduct:product];
    [delegate backButtonWasHit:self];
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
    //Table Formatting
    static NSString *CellIdentifier = @"SegueCell";
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 438, 44)];
    cell.accessoryView = cellView;
    UIView *columnView = [[UIView alloc] initWithFrame:CGRectMake(cellView.frame.size.width/2, 0, 1, cellView.frame.size.height)];
    columnView.backgroundColor = [UIColor grayColor];
    [cellView addSubview:columnView];
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 9, cellView.frame.size.width/2 -12, cellView.frame.size.height)];
    nameField.font = font;
    UITextField *priceField = [[UITextField alloc] initWithFrame:CGRectMake(cellView.frame.size.width/2 + 10, 9, cellView.frame
                                                                            .size.width/2 -10, cellView.frame.size.height)];
    priceField.font = font;
    [cellView addSubview:nameField];
    [cellView addSubview:priceField];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    nameField.placeholder = @"Name";
    priceField.placeholder = @"$0.00";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if((product.variation.count -1) >= [indexPath row])
    {
        NSLog(@"Variations: %@", [editManager getVariationListFromProduct:product]);
        nameField.text = [[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] name];
        priceField.text =  [numberFormatter stringFromNumber:[[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] price]];
    }
    
    [nameField addTarget:self action:@selector(saveName:) forControlEvents:UIControlEventEditingDidEnd];
    [priceField addTarget:self action:@selector(savePrice:) forControlEvents:UIControlEventEditingDidEnd];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] != 0)
    {
        if(editingStyle == UITableViewCellEditingStyleDelete)
        {
            [editManager deleteVariation:[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row] ] inProduct:product];
            variationCount--;
            [self.variationTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }

}
-(void)saveName:(UITextField*)sender
{
    UITableViewCell *cell = (UITableViewCell*)sender.superview.superview;
    NSIndexPath *path = [variationTableView indexPathForCell:cell];
    NSUInteger row = path.row;
    [editManager changeVariation:[[editManager getVariationListFromProduct:product] objectAtIndex:row] nameTo:sender.text];
}

-(void)savePrice:(UITextField*)sender
{
    UITableViewCell *cell = (UITableViewCell*)sender.superview.superview;
    NSIndexPath *path = [variationTableView indexPathForCell:cell];
    NSUInteger row = path.row;
    NSNumber *price = [editManager convertCurrencyToNumber:sender.text];
    [editManager changeVariation:[[editManager getVariationListFromProduct:product] objectAtIndex:row] priceTo:price];
}

- (IBAction)addVariation:(UIBarButtonItem *)sender
{
    variationCount++;
    [editManager addVariationToProduct:product withName:nil andPrice:nil];
    [variationTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    variationCount = [[product variation] count];
    [variationTableView reloadData];
}

- (void)viewDidUnload {
    [self setVariationTableView:nil];
    [super viewDidUnload];
}
@end
