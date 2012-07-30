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
    NSLog(@"THIS SHOULD NOT RUN!!!!!!!!!!!!!!!");
    if(self = [super init])
    {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSString *plistPath = [docDir stringByAppendingPathComponent:@"favoriteProducts.plist"];
        if([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            NSLog(@"[FOUND PLIST]");
            source = [NSMutableArray arrayWithContentsOfFile:plistPath];
            favList0 = [source objectAtIndex:0];
            favList1 = [source objectAtIndex:1];
            favList2 = [source objectAtIndex:2];
            favList3 = [source objectAtIndex:3];
            favList4 = [source objectAtIndex:4];
        }else 
        {
            NSLog(@"[COULD NO FIND PLIST] CREATING A NEW ONE");
            source = [[NSMutableArray alloc] init];
            favList0 = [[FavoriteList alloc] init];
            favList1 = [[FavoriteList alloc] init];
            favList2 = [[FavoriteList alloc] init];
            favList3 = [[FavoriteList alloc] init];
            favList4 = [[FavoriteList alloc] init];
            
            [source addObject:favList0];
            [source addObject:favList1];
            [source addObject:favList2];
            [source addObject:favList3];
            [source addObject:favList4];
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
    [source writeToFile:plistPath atomically:YES];
}


@end
