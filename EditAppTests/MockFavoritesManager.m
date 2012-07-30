//
//  MockFavoritesManager.m
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "MockFavoritesManager.h"
#import "FavoriteList.h"
@implementation MockFavoritesManager

-(id)init
{
    self.favList0 = [[FavoriteList alloc] init];
    self.favList1 = [[FavoriteList alloc] init];
    self.favList2 = [[FavoriteList alloc] init];
    self.favList3 = [[FavoriteList alloc] init];
    self.favList4 = [[FavoriteList alloc] init];
    return self;
}

@end
