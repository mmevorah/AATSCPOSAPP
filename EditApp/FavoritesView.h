//
//  FavoritesView.h
//  EditApp
//
//  Created by Mark Mevorah on 8/6/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IndiFavorite;
@class EditManager;
@class FavoriteList;

@interface FavoritesView : UIView
{
    NSMutableArray *favoriteButtonArray;
    NSMutableArray *favoriteManagerList;
}

@property (strong, nonatomic) EditManager *editManager;
@property NSInteger favoritesListNumber;

-(void)reloadFavoritesView;

@end
