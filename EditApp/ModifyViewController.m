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
    
    /*
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    self.navigationController
    */
    
    if(product.image)
    {
        [imageButton setImage:product.image forState:UIControlStateNormal];
        [imageButton setImage:product.image forState:UIControlStateSelected];
    }
     
    if(product == nil)
    {
        self.product = [self.editManager createProductShell];
    }
    
    [textFieldTable setBackgroundView:nil];
    disclosureButton.hidden = YES;

    self.variationViewController = [[VariationViewController alloc] initWithNibName:@"VariationViewController" bundle:nil];
    self.variationViewController.editManager = self.editManager;
    self.variationViewController.product = self.product;
    self.variationViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.variationViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    self.variationViewController.delegate = self;
    
    self.cameraOptionsViewController = [[CameraOptionsViewController alloc] initWithNibName:@"CameraOptionsViewController" bundle:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"called!");

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
        priceField.keyboardType = UIKeyboardTypeNumberPad;
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
    @try{
        NSLog(@"Tried to name");
        NSString *name = [[nameCell.accessoryView.subviews objectAtIndex:0] text];
        [editManager changeProduct:product nameTo:name];
    }
    @catch (NSException *yo) {
        NSLog(@"Cought name");
        NSString *name = [[nameCell.accessoryView.subviews objectAtIndex:1] text];
        [editManager changeProduct:product nameTo:name];
    }
    UITableViewCell *priceCell = [textFieldTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    @try {
        NSLog(@"Tried to price");
        NSNumber *price = [NSNumber numberWithDouble:[[[priceCell.accessoryView.subviews objectAtIndex:0] text] doubleValue]];
        [editManager changeProduct:product masterPriceTo:price];
    }
    @catch (NSException *exception) {
        NSLog(@"Cought price");
        NSNumber *price = [NSNumber numberWithDouble:[[[priceCell.accessoryView.subviews objectAtIndex:1] text] doubleValue]];
        [editManager changeProduct:product masterPriceTo:price];
    }
}

- (IBAction)disclosureButtonAction:(UIButton *)sender {
    [self saveNameandPrice];
    [self presentViewController:self.variationViewController animated:YES completion:NULL];
}

- (IBAction)saveButton:(UIBarButtonItem *)sender {
    [self saveNameandPrice];
    [delegate theSaveButtonHasBeenHit:self];
    [editManager saveContext];
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender {
    [editManager cancelContext];
    [delegate theCancelButtonHasBeenHit:self];
}

-(void)backButtonWasHit:(VariationViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)cameraButton:(UIButton *)sender {
    [self saveNameandPrice];
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
    imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
    imagePicker.allowsEditing = NO;
    
    self.popOverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    self.popOverController.delegate = self;
    [self.popOverController presentPopoverFromRect:CGRectMake(0, 100, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
   
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
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
     self.view.superview.frame = CGRectMake(self.view.superview.superview.center.x - 250, self.view.superview.superview.center.y - 125, 500, 250);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [editManager changeProduct:product imageTo:image];
    [imageButton setImage:image forState: UIControlStateNormal];
    [imageButton setImage:image forState:UIControlStateSelected];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
