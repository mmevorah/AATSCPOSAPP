//
//  FavoritesManager.m
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "FavoritesManager.h"
#import "FavoriteList.h"
@implementation FavoritesManager

@synthesize source;
@synthesize favList0, favList1, favList2, favList3, favList4;

-(id)init
{
    if(self = [super init])
    {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSString *plistPath = [docDir stringByAppendingPathComponent:@"favoriteProducts.plist"];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            NSLog(@"[FOUND PLIST For Favorites Manager]");
            source = [NSMutableArray arrayWithContentsOfFile:plistPath];
                        
            favList0 = [[FavoriteList alloc] init];
            favList1 = [[FavoriteList alloc] init];
            favList2 = [[FavoriteList alloc] init];
            favList3 = [[FavoriteList alloc] init];
            favList4 = [[FavoriteList alloc] init];
            
            favList0.list = [source objectAtIndex:0];
            favList1.list = [source objectAtIndex:1];
            favList2.list = [source objectAtIndex:2];
            favList3.list = [source objectAtIndex:3];
            favList4.list = [source objectAtIndex:4];
        }else 
        {
            NSLog(@"[COULD NO FIND PLIST For Favorites Manager] CREATING A NEW ONE");
            
            favList0 = [[FavoriteList alloc] init];
            favList1 = [[FavoriteList alloc] init];
            favList2 = [[FavoriteList alloc] init];
            favList3 = [[FavoriteList alloc] init];
            favList4 = [[FavoriteList alloc] init];
            
            source = [[NSMutableArray alloc] init];
            [source addObject:favList0.list];
            [source addObject:favList1.list];
            [source addObject:favList2.list];
            [source addObject:favList3.list];
            [source addObject:favList4.list];
            
            [self saveFavorites];
        }
    }
    return self;
}

-(void)insertProductWithID:(NSNumber*)productID intoFavoritesList:(int)favList atPosition:(int)pos
{
    if(favList == 0)
    {
        [favList0 addProductWithID:productID toPosition:pos];
    }else if (favList == 1)
    {
        [favList1 addProductWithID:productID toPosition:pos];
    }else if (favList == 2)
    {
        [favList2 addProductWithID:productID toPosition:pos];
    }else if (favList == 3)
    {
        [favList3 addProductWithID:productID toPosition:pos];
    }else if (favList == 4)
    {
        [favList4 addProductWithID:productID toPosition:pos];
    }
}

-(void)removeProductFromList:(int)favList atPostion:(int)pos
{
    if(favList == 0)
    {
        [favList0 clearProductAtPosition:pos];
    }else if (favList == 1)
    {
        [favList1 clearProductAtPosition:pos];
    }else if (favList == 2)
    {
        [favList2 clearProductAtPosition:pos];
    }else if (favList == 3)
    {
        [favList3 clearProductAtPosition:pos];
    }else if (favList == 4)
    {
        [favList4 clearProductAtPosition:pos];
    }
}

-(void)saveFavorites
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *plistPath = [docDir stringByAppendingPathComponent:@"favoriteProducts.plist"];
    
    [source replaceObjectAtIndex:0 withObject:favList0.list];
    [source replaceObjectAtIndex:1 withObject:favList1.list];
    [source replaceObjectAtIndex:2 withObject:favList2.list];
    [source replaceObjectAtIndex:3 withObject:favList3.list];
    [source replaceObjectAtIndex:4 withObject:favList4.list];
    
    [source writeToFile:plistPath atomically:NO];
}


@end
