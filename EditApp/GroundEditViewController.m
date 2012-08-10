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
#import "FavoritesView.h"
#import "Product.h"
#import <QuartzCore/QuartzCore.h>
#import "ModifyViewController.h"
#import "IDManager.h"
#import "DragableView.h"
@interface GroundEditViewController ()

@end

@implementation GroundEditViewController

@synthesize searchBar;
@synthesize favoritesView0;
@synthesize favoritesView1;
@synthesize favoritesView2;
@synthesize favoritesView3;
@synthesize favoritesView4;

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
    
    productList = [editManager getProductList:nil];
    productSearchText = nil;
    
	// Do any additional setup after loading the view.
    libraryView.layer.cornerRadius = 5;
    libraryView.layer.masksToBounds = YES;
    libraryView.hidden = FALSE;
    
    favoritesView0.editManager = self.editManager;
    favoritesView0.favoritesListNumber = 0;
    favoritesView0.hidden = TRUE;
    
    favoritesView1.editManager = self.editManager;
    favoritesView1.favoritesListNumber = 1;
    favoritesView1.hidden = TRUE;
    
    favoritesView2.editManager = self.editManager;
    favoritesView2.favoritesListNumber = 2;
    favoritesView2.hidden = TRUE;
    
    favoritesView3.editManager = self.editManager;
    favoritesView3.favoritesListNumber = 3;
    favoritesView3.hidden = TRUE;
    
    favoritesView4.editManager = self.editManager;
    favoritesView4.favoritesListNumber = 4;
    favoritesView4.hidden = TRUE;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[self packageSegmentedControllerArray]];
    CGPoint segmentedControlLocation = CGPointMake(self.view.center.x, self.view.frame.size.height - 75);
    self.segmentedControl.center = segmentedControlLocation;
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
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
    
    for(int i = 0; i < 5; i++)
    {
        [array addObject:@"Favorite"];
    }
    return array;
}

-(void)segmentChanged:(UISegmentedControl*)sender
{
    if([sender isEqual:self.segmentedControl])
    {
        NSInteger selectedSegmentIndex = [sender selectedSegmentIndex];
        if(selectedSegmentIndex == 0)
        {
            libraryView.hidden = FALSE;
            favoritesView0.hidden = TRUE;
            favoritesView1.hidden = TRUE;
            favoritesView2.hidden = TRUE;
            favoritesView3.hidden = TRUE;
            favoritesView4.hidden = TRUE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;
        }else if(selectedSegmentIndex == 1)
        {
            libraryView.hidden = TRUE;
            favoritesView0.hidden = FALSE;
            favoritesView1.hidden = TRUE;
            favoritesView2.hidden = TRUE;
            favoritesView3.hidden = TRUE;
            favoritesView4.hidden = TRUE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;

        }else if(selectedSegmentIndex == 2)
        {
            libraryView.hidden = TRUE;
            favoritesView0.hidden = TRUE;
            favoritesView1.hidden = FALSE;
            favoritesView2.hidden = TRUE;
            favoritesView3.hidden = TRUE;
            favoritesView4.hidden = TRUE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;

        }else if(selectedSegmentIndex == 3)
        {
            libraryView.hidden = TRUE;
            favoritesView0.hidden = TRUE;
            favoritesView1.hidden = TRUE;
            favoritesView2.hidden = FALSE;
            favoritesView3.hidden = TRUE;
            favoritesView4.hidden = TRUE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;

        }else if(selectedSegmentIndex == 4)
        {
            libraryView.hidden = TRUE;
            favoritesView0.hidden = TRUE;
            favoritesView1.hidden = TRUE;
            favoritesView2.hidden = TRUE;
            favoritesView3.hidden = FALSE;
            favoritesView4.hidden = TRUE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;

        }else if(selectedSegmentIndex == 5)
        {
            libraryView.hidden = TRUE;
            favoritesView0.hidden = TRUE;
            favoritesView1.hidden = TRUE;
            favoritesView2.hidden = TRUE;
            favoritesView3.hidden = TRUE;
            favoritesView4.hidden = FALSE;
            
            [dragableView removeFromSuperview];
            dragableView = nil;

        }
    }
}

- (void)viewDidUnload {
    [self setLibraryView:nil];
    [self setFavoritesView0:nil];
    [self setFavoritesView1:nil];
    [self setFavoritesView2:nil];
    [self setFavoritesView3:nil];
    [self setFavoritesView4:nil];
    [super viewDidUnload];
}

#pragma mark preparingLibraryView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[editManager getProductList:productSearchText]count];
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
    cell.textLabel.text = [[productList objectAtIndex:[indexPath row]] name];
    
    //price
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = font;
    cell.detailTextLabel.text = [numberFormatter stringFromNumber:[[productList objectAtIndex:[indexPath row]]masterPrice]];
    
    //image
    if([[productList objectAtIndex:[indexPath row]]image] == nil)
    {
        UIImage *image = [UIImage imageNamed:@"emptyImage.png"];
        cell.imageView.image = image;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }else
    {
        cell.imageView.image = [[productList objectAtIndex:[indexPath row]]image];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    UILongPressGestureRecognizer *timedSelect = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleSelection:)];
    timedSelect.minimumPressDuration = 1;
    [cell addGestureRecognizer:timedSelect];
    
    return cell;
}

-(void)handleSelection:(UIGestureRecognizer*)sender
{
    if(sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"Long cell selection");
        CGPoint pressPoint = [sender locationInView:productTableView];
        NSIndexPath *indexPath = [productTableView indexPathForRowAtPoint:pressPoint];
        
        if(dragableView == nil)
        {
            dragableView = [[DragableView alloc] initWithFrame:CGRectMake(productTableView.frame.origin.x+ pressPoint.x,productTableView.frame.origin.y+ pressPoint.y + 100, 102, 122)];
            initialDragableViewLocation = CGPointMake(productTableView.frame.origin.x+ pressPoint.x + 51, productTableView.frame.origin.y+ pressPoint.y + 100 + 61);
            Product *adiPure = [productList objectAtIndex:[indexPath row]];
            dragableView.imageView.image = adiPure.image;
            dragableView.label.text = adiPure.name;
            dragableView.product = adiPure;
            [self.view addSubview:dragableView];
            [self touchesBegan:nil withEvent:nil];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    dragableView.center = initialDragableViewLocation;
    //[self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view.superview.superview];
    initialDragableViewLocation = location;

    if([touch.view.superview class] != [dragableView class])
    {
        [dragableView removeFromSuperview];
        dragableView = nil;
    }
        
    dragableView.center = initialDragableViewLocation;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view.superview.superview];
    [self favoriteDropOff:location withProduct:dragableView.product];
    [dragableView removeFromSuperview];
    dragableView = nil;
}

-(void)favoriteDropOff:(CGPoint)location withProduct:(Product*)product
{
    float originX = segmentedControl.frame.origin.x;
    
    if((location.y > 928) && (location.y < 971))
    {
        if((location.x > (originX+87)) && (location.x < (originX+87+87)))
        {
            NSLog(@"Product Put in Fav0");
            [editManager addProductToFavoritesWithID:product.iD toFavoritesList:0 atPosition:[NSNumber numberWithInteger:[editManager getNextAvailablePositionFromFavoritesList:0]]];
            [favoritesView0 reloadFavoritesView];
        }else if((location.x > (originX+87+87)) && (location.x < (originX+87+87+87)))
        {
            NSLog(@"fav1");
            [editManager addProductToFavoritesWithID:product.iD toFavoritesList:1 atPosition:[NSNumber numberWithInteger:[editManager getNextAvailablePositionFromFavoritesList:1]]];
            [favoritesView1 reloadFavoritesView];
        }else if((location.x > (originX+87+87+87)) && (location.x < (originX+87+87+87+87)))
        {
            NSLog(@"fav2");
            [editManager addProductToFavoritesWithID:product.iD toFavoritesList:2 atPosition:[NSNumber numberWithInteger:[editManager getNextAvailablePositionFromFavoritesList:2]]];
            [favoritesView2 reloadFavoritesView];
        }else if((location.x > (originX+87+87+87+87)) && (location.x < (originX+87+87+87+87+87)))
        {
            NSLog(@"fav3");
            [editManager addProductToFavoritesWithID:product.iD toFavoritesList:3 atPosition:[NSNumber numberWithInteger:[editManager getNextAvailablePositionFromFavoritesList:3]]];
            [favoritesView3 reloadFavoritesView];
        }else if((location.x > (originX+87+87+87+87+87)) && (location.x < (originX+87+87+87+87+87+87)))
        {
            NSLog(@"fav4");
            [editManager addProductToFavoritesWithID:product.iD toFavoritesList:4 atPosition:[NSNumber numberWithInteger:[editManager getNextAvailablePositionFromFavoritesList:4]]];
            [favoritesView4 reloadFavoritesView];
        }
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModifyViewController *modifyViewController = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    
    modifyViewController.editManager = self.editManager;
    NSLog(@"The product sent is: %@", [productList objectAtIndex:[indexPath row]]);
    modifyViewController.product = [productList objectAtIndex:[indexPath row]];
    
    modifyViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    modifyViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:modifyViewController animated:YES completion:NULL];
    modifyViewController.view.superview.frame = CGRectMake(0, 0, 500, 250);
    modifyViewController.view.superview.center = self.view.center;
    
    modifyViewController.titleBarTitle.text = @"Edit Item";
    modifyViewController.saveButton.enabled = YES;
    modifyViewController.disclosureButton.hidden = NO;
    modifyViewController.delegate = self;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [editManager deleteProduct:[productList objectAtIndex:[indexPath row]]];
        productList = [editManager getProductList:nil];
        [self.productTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [favoritesView0 reloadFavoritesView];
        [favoritesView1 reloadFavoritesView];
        [favoritesView2 reloadFavoritesView];
        [favoritesView3 reloadFavoritesView];
        [favoritesView4 reloadFavoritesView];
        [editManager saveContext];
    }
}

#pragma mark searchFunctionality

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    productSearchText = searchText;
    productList = [editManager getProductList:searchText];
    [productTableView reloadData];
}

#pragma mark preparingForCreateProductView

- (IBAction)addButton:(UIBarButtonItem *)sender
{    
    ModifyViewController *modifyViewController = [[ModifyViewController alloc] initWithNibName:@"ModifyViewController" bundle:nil];
    modifyViewController.editManager = self.editManager;

    modifyViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    modifyViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:modifyViewController animated:YES completion:NULL];
    modifyViewController.view.superview.frame = CGRectMake(0, 0, 500, 250);
    modifyViewController.view.superview.center = self.view.center;
    
    modifyViewController.titleBarTitle.text = @"Create Item";
    modifyViewController.saveButton.enabled = NO;
    modifyViewController.delegate = self;
}

-(void)theSaveButtonHasBeenHit:(ModifyViewController*)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    productList = [editManager getProductList:productSearchText];
    [productTableView reloadData];
}

-(void)theCancelButtonHasBeenHit:(ModifyViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


@end
