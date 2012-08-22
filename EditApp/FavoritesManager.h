//
//  FavoritesManager.h
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FavoriteList;
@interface FavoritesManager : NSObject

@property(strong, nonatomic)NSMutableArray *source;

@property(strong, nonatomic)FavoriteList *favList0;
@property(strong, nonatomic)FavoriteList *favList1;
@property(strong, nonatomic)FavoriteList *favList2;
@property(strong, nonatomic)FavoriteList *favList3;
@property(strong, nonatomic)FavoriteList *favList4;

-(void)insertProductWithID:(NSNumber*)productID intoFavoritesList:(int)favList atPosition:(int)pos;
-(void)removeProductFromList:(int)favList atPostion:(int)pos;

-(void)saveFavorites;

-(id)init;


@end
