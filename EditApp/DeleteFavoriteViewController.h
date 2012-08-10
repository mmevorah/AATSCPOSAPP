//
//  DeleteFavoriteViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 8/10/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeleteFavoriteViewController;

@protocol DeleteFavoriteControllerDelegate <NSObject>

-(void)deleteFavoriteWasHit:(DeleteFavoriteViewController*)sender;

@end

@interface DeleteFavoriteViewController : UIViewController

@property NSInteger list;
@property NSInteger position;
@property (strong, nonatomic) id<DeleteFavoriteControllerDelegate>delegate;

- (IBAction)button:(UIButton *)sender;

@end
