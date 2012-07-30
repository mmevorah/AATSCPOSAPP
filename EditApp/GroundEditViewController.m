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
@interface GroundEditViewController ()

@end

@implementation GroundEditViewController

@synthesize editManager;
@synthesize segmentedControl;

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
	// Do any additional setup after loading the view.
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[self packageSegmentedControllerArray]];
    CGPoint segmentedControlLocation = CGPointMake(self.view.center.x, self.view.frame.size.height - 100);
    self.segmentedControl.center = segmentedControlLocation;
    [self.view addSubview:self.segmentedControl];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSArray*)packageSegmentedControllerArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"Library"];
    
    for(int i = 0; i < [[editManager numberOfActiveFavorites] intValue]; i++)
    {
        [array addObject:@"Favorite"];
    }
    if([[editManager numberOfActiveFavorites] intValue] == 0)
    {
        [array addObject:@"Favorite"];
        [array addObject:@"Favorite"];
    }
    
    return array;
}

@end
