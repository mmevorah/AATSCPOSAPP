//
//  Product.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "Product.h"
#import "Variation.h"


@implementation Product

@dynamic iD;
@dynamic image;
@dynamic name;
@dynamic variation;

-(NSNumber *)masterPrice
{
    NSArray *variations = [NSArray arrayWithArray: self.variation.allObjects];
    for(int i = 0; i < self.variation.count ; i++)
    {
        if([[[variations objectAtIndex:i] master] boolValue] == YES)
        {
            return [[variations objectAtIndex:i] price];
        }
    }
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could'nt Find Master Variation" delegate:nil cancelButtonTitle:@"Darn!"otherButtonTitles:nil, nil];
    [error show];
    return nil;
}

@end
