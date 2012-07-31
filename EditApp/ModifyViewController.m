//
//  ModifyViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 7/31/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ModifyViewController.h"
#import "EditManager.h"
#import "VariationViewController.h"

@interface ModifyViewController ()

@end

@implementation ModifyViewController

@synthesize saveButton;
@synthesize imageButton;
@synthesize textFieldTable;
@synthesize disclosureButton;
@synthesize titleBarTitle;
@synthesize editManager;
@synthesize variationViewController;
@synthesize navigationController;

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
    
    product = [self.editManager createProductWithAName:@"Mark" anImage:nil andAPrice:[NSNumber numberWithDouble:22.3]];
    self.variationViewController = [[VariationViewController alloc] initWithNibName:@"VariationViewController" bundle:nil];
    self.variationViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.variationViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    disclosureButton.hidden = YES;
    [textFieldTable setBackgroundView:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SegueCell";
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if(indexPath.row == 0)
    {
        UITextField* nameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 245, 25)];
        nameField.font = font;
        nameField.placeholder = @"Item Name";
        cell.accessoryView = nameField;
        [nameField addTarget:self action:@selector(enableSave:) forControlEvents:UIControlEventEditingDidEnd];
        [nameField addTarget:self action:@selector(setName:) forControlEvents:UIControlEventAllEditingEvents];
    }else if(indexPath.row == 1)
    {
        UITextField* priceField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 245, 25)];
        priceField.font = font;
        priceField.placeholder = @"$0.00";
        cell.accessoryView = priceField;        
        [priceField addTarget:self action:@selector(enableVariationView:) forControlEvents:UIControlEventEditingDidEnd];
        [priceField addTarget:self action:@selector(setPrice:) forControlEvents:UIControlEventAllEditingEvents];
}
    
    return cell;
}

-(void)setName:(UITextField*)sender
{
    [editManager changeProduct:product nameTo:sender.text];
}

-(void)setPrice:(UITextField*)sender
{
    [editManager changeProduct:product masterPriceTo: [NSNumber numberWithDouble:[sender.text doubleValue]]];
}

-(void)enableSave:(UITextField*)sender
{
    if(![sender.text isEqualToString: @""])
    {
        saveButton.enabled = YES;
    }else if([sender.text isEqualToString:@""])
    {
        saveButton.enabled = NO;
    }
}

-(void)enableVariationView:(UITextField*)sender
{
    if(![sender.text isEqualToString: @""])
    {
        disclosureButton.hidden = NO;
    }else if([sender.text isEqualToString:@""])
    {
        disclosureButton.hidden = YES;
    }
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    [delegate theSaveButtonHasBeenHit];
    [editManager saveContext];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [editManager cancelContext];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)disclosureButtonAction:(UIButton *)sender {
    [self presentModalViewController:self.variationViewController animated:YES];
}


- (void)viewDidUnload {
    [self setSaveButton:nil];
    [self setImageButton:nil];
    [self setTextFieldTable:nil];
    [self setTitleBarTitle:nil];
    [self setDisclosureButton:nil];
    [super viewDidUnload];
}

@end
