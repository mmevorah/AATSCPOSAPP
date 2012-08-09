//
//  FavoritesView.m
//  EditApp
//
//  Created by Mark Mevorah on 8/6/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "FavoritesView.h"
#import "IndiFavorite.h"
#import "EditManager.h"
#import "FavoritesManager.h"
#import "FavoriteList.h"
#import "Product.h"

@implementation FavoritesView

@synthesize favoritesListNumber;
@synthesize editManager;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    favoriteButtonArray = [[NSMutableArray alloc] init];
    
    [self configureFavoritesList];
    [self positionButtons];
    [self reloadFavoritesView];

    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)positionButtons
{
    int startX = 15;
    int startY = 15;
    
    for(int i = 0; i < 25; i++)
    {
        IndiFavorite *button = [[IndiFavorite alloc] init];
        [favoriteButtonArray addObject:button];
        
        if(((i%5) == 0) && (i != 0))
        {
            startY += 131;
            startX = 11;
        }
        
        button.frame = CGRectMake(startX, startY, 120, 120);
        [self addSubview:button];
        
        startX += 131;
    }
}

-(void)configureFavoritesList
{
    if(favoritesListNumber == 0)
    {
        NSLog(@"Favorites Manager %@", editManager.favoriteManager.favList0);
        favoriteManagerList = editManager.favoriteManager.favList0.list;
    }else if(favoritesListNumber == 1)
    {
        favoriteManagerList = editManager.favoriteManager.favList1.list;
    }else if(favoritesListNumber == 2)
    {
        favoriteManagerList = editManager.favoriteManager.favList2.list;
    }else if(favoritesListNumber == 3)
    {
        favoriteManagerList = editManager.favoriteManager.favList3.list;
    }else if(favoritesListNumber == 4)
    {
        favoriteManagerList = editManager.favoriteManager.favList4.list;
    }
}

-(void)reloadFavoritesView
{
    for(int i  = 0; i < 25; i++)
    {
        IndiFavorite *favoriteButton = [favoriteButtonArray objectAtIndex:i];
        NSNumber *iD = [favoriteManagerList objectAtIndex:i];
        favoriteButton.productID = iD;
        if([iD integerValue] != -1)
        {
            [favoriteButton setImage:[[editManager productFromID:iD] image] forState:UIControlStateNormal];
        }else
        {
            [favoriteButton setImage: [UIImage imageNamed:@"emptyImage.png"] forState:UIControlStateNormal];
        }
    }
}



@end
