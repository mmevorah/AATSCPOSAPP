//
//  DeleteFavoriteViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/10/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "DeleteFavoriteViewController.h"

@interface DeleteFavoriteViewController ()

@end

@implementation DeleteFavoriteViewController

@synthesize delegate;
@synthesize list;
@synthesize position;

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
    self.contentSizeForViewInPopover = CGSizeMake(200, 60);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button:(UIButton *)sender {
    [delegate deleteFavoriteWasHit:self];
}
@end
