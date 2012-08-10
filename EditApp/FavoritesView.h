//
//  FavoritesView.h
//  EditApp
//
//  Created by Mark Mevorah on 8/6/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeleteFavoriteViewController.h"
@class IndiFavorite;
@class EditManager;
@class FavoriteList;
@class DeleteFavoriteViewController;

@interface FavoritesView : UIView <DeleteFavoriteControllerDelegate>
{
    NSMutableArray *favoriteButtonArray;
    NSMutableArray *favoriteManagerList;
}

@property (strong, nonatomic) EditManager *editManager;
@property NSInteger favoritesListNumber;
@property (strong, nonatomic) UIPopoverController *popoverController;

-(void)reloadFavoritesView;

@end
