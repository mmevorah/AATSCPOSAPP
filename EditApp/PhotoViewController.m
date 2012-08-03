//
//  PhotoViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/3/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

@synthesize navigationController;
@synthesize popOverController;

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

    UIImagePickerController *controller = [[UIImagePickerController alloc] initWithRootViewController:self];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
    
    [self.view addSubview:controller.view];
    popOverController = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    
    self.navigationController.navigationBarHidden = NO;
    controller.delegate = self;
    
    [self.popOverController presentPopoverFromRect:CGRectMake(0, 0, 200, 200) inView:self.view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
