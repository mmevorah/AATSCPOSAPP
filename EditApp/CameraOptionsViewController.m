//
//  CameraOptionsViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/2/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "CameraOptionsViewController.h"

@interface CameraOptionsViewController ()

@end

@implementation CameraOptionsViewController

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
    self.contentSizeForViewInPopover = CGSizeMake(250, 100.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoFromAlbum:(UIButton *)sender
{
    [delegate photoFromAlbumSelected];
}

- (IBAction)photoFromCamera:(UIButton *)sender
{
    [delegate photoFromCameraSelected];
}


@end
