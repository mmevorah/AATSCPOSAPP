//
//  FavoriteList.m
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "FavoriteList.h"

@implementation FavoriteList
@synthesize list;
@synthesize hidden;

-(id)init
{
    if(self = [super init])
    {
        hidden = YES;
        list = [[NSMutableArray alloc] init];
        [self setUpList];
    }
    return self;
}

-(void)setUpList
{
    for(int i = 0; i < 25; i++)
    {
        [self.list addObject:[NSNumber numberWithInt:-1]];
    }
}

-(int)size
{
    return (int)list.count;
}

-(void)addProductWithID:(NSNumber *)productID toPosition:(int)posNumber
{
    if(posNumber < 25)
    {
        if([[list objectAtIndex:posNumber] intValue] == -1)
        {
            [list replaceObjectAtIndex:posNumber withObject:productID];
        }
    }
}

-(void)clearProductAtPosition:(int)posNumber
{
    if(posNumber < 25)
    {
        if([[list objectAtIndex:posNumber] intValue] != -1)
        {
            [list replaceObjectAtIndex:posNumber withObject:[NSNumber numberWithInt:-1]];
        }
    }
}



@end
