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
    NSLog(@"A");
    int variantArrayIterator = 0;
    NSArray *array = [editManager getVariationListFromProduct:product];
    NSLog(@"B");
    for(int i = 0; i <= (variationTableView.indexPathsForVisibleRows.count-1); i++)
    {
        NSLog(@"C");
        UITableViewCell *cell = [variationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        NSString *name = [[cell.accessoryView.subviews objectAtIndex:1] text];
        NSNumber *price = [editManager convertCurrencyToNumber:[[cell.accessoryView.subviews objectAtIndex:2] text]];
        NSLog(@"D");

        if(![name isEqualToString:@""] && (name != NULL))
        {
            NSLog(@"E and : %@", name);

            if(variantArrayIterator >= array.count)
            {
                NSLog(@"F");

                [editManager addVariationToProduct:product withName:name andPrice:price];
                NSLog(@"G");

            }else
            {
                NSLog(@"H");

                [editManager changeVariation:[array objectAtIndex:variantArrayIterator] nameTo:name];
                [editManager changeVariation:[array objectAtIndex:variantArrayIterator] priceTo:price];
                NSLog(@"I");

            }
            NSLog(@"J");

            variantArrayIterator++;
            NSLog(@"K");

        }
    }
    NSLog(@"L");

    if(variantArrayIterator < array.count)
    {
        NSLog(@"M");

        for(int j = variantArrayIterator; j < array.count; j++)
        {

            [editManager deleteVariation:[array objectAtIndex:j] inProduct:product];
            NSLog(@"N");

        }
    }
    NSLog(@"O");

    [self dismissModalViewControllerAnimated:YES];
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
    
    if((product.variation.count -1) == [indexPath row])
    {
        NSLog(@"GO!");
        nameField.text = [[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] name];
        priceField.text =  [numberFormatter stringFromNumber:[[[editManager getVariationListFromProduct:product] objectAtIndex:[indexPath row]] price]];
    }
        
    return cell;
}


- (IBAction)addVariation:(UIBarButtonItem *)sender
{
    variationCount++;
    [variationTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [variationTableView reloadData];
}

- (void)viewDidUnload {
    [self setVariationTableView:nil];
    [super viewDidUnload];
}
@end
