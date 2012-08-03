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
#import "Variation.h"
#import "Product.h"
#import "CameraOptionsViewController.h"
#import "PhotoViewController.h"


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
@synthesize product;
@synthesize delegate;
@synthesize popOverController;
@synthesize cameraOptionsViewController;
@synthesize photoViewController;
@synthesize navigationController;

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
    
    if(product.image != nil)
    {
        imageButton.imageView.image = product.image;
    }
    [textFieldTable setBackgroundView:nil];
    disclosureButton.hidden = YES;
     
    self.product = [self.editManager createProductShell];
    
    /*
    self.variationViewController = [[VariationViewController alloc] initWithNibName:@"VariationViewController" bundle:nil];
    self.variationViewController.editManager = self.editManager;
    self.variationViewController.product = self.product;
    self.variationViewController.delegate = self;
    self.variationViewController.navigationController = navigationController;
    */
     
    self.cameraOptionsViewController = [[CameraOptionsViewController alloc] initWithNibName:@"CameraOptionsViewController" bundle:nil];
    self.photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController" bundle:nil];
    self.photoViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.photoViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

-(void)viewDidAppear:(BOOL)animated
{
    [textFieldTable reloadData];
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
    //TableFormatting
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
        
        if(![product.name isEqualToString:nil] && ![product.name isEqualToString:@""])
        {
            nameField.text = self.product.name;
        }
        
        [nameField addTarget:self action:@selector(enableSave:) forControlEvents:UIControlEventEditingDidEnd];
    }
    else if(indexPath.row == 1)
    {
        UITextField* priceField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 245, 25)];
        priceField.font = font;
        priceField.placeholder = @"$0.00";
        cell.accessoryView = priceField;
        
        if([product.masterPrice doubleValue] != -3.111)
        {
            priceField.text = [[self.product masterPrice] stringValue];
        }
        [priceField addTarget:self action:@selector(enableVariationView:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return cell;
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

-(void)saveNameandPrice
{
    UITableViewCell *nameCell = [textFieldTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *name = [[nameCell.accessoryView.subviews objectAtIndex:0] text];
    [editManager changeProduct:product nameTo:name];
    UITableViewCell *priceCell = [textFieldTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSNumber *price = [NSNumber numberWithDouble:[[[priceCell.accessoryView.subviews objectAtIndex:0] text] doubleValue]];
    [editManager changeProduct:product masterPriceTo:price];
}

- (IBAction)disclosureButtonAction:(UIButton *)sender {
    [self saveNameandPrice];
    [self.navigationController pushViewController:self.variationViewController animated:YES];
    self.variationViewController.editManager = self.editManager;
    self.variationViewController.product = self.product;
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    [self saveNameandPrice];
    [delegate theSaveButtonHasBeenHit];
    [editManager saveContext];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [editManager cancelContext];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)backButtonWasHit:(VariationViewController *)controller
{
    NSLog(@"delegate used whent he back button was pressed");
    [variationViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)cameraButton:(UIButton *)sender {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cameraOptionsViewController];
    [navController setNavigationBarHidden:YES];
    self.popOverController = [[UIPopoverController alloc] initWithContentViewController:navController];
    cameraOptionsViewController.delegate = self;
    [self.popOverController presentPopoverFromRect:CGRectMake(0, 0, sender.frame.size.width, sender.frame.size.height - 30) inView:sender.imageView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(void)photoFromAlbumSelected
{
    [popOverController dismissPopoverAnimated:YES];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage, nil];
    
    [self.navigationController presentModalViewController:imagePicker animated:YES];
}

-(void)photoFromCameraSelected
{
    [popOverController dismissPopoverAnimated:YES];
    
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        imagePicker.navigationBarHidden = TRUE;
        [self presentModalViewController:imagePicker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
     self.view.superview.frame = CGRectMake(self.view.superview.superview.center.x - 250, self.view.superview.superview.center.y - 125, 500, 250);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [editManager changeProduct:product imageTo:image];
    [imageButton setImage:image forState: UIControlStateNormal];
    [imageButton setImage:image forState:UIControlStateSelected];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    self.view.superview.frame = CGRectMake(self.view.superview.superview.center.x - 250, self.view.superview.superview.center.y - 125, 500, 250);
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
