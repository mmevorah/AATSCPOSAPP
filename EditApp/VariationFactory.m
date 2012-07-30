//
//  VariationFactory.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "VariationFactory.h"
#import "Variation.h"

@implementation VariationFactory
@synthesize context;

-(Variation *)createVariationWithTheName:(NSString *)name thePrice:(NSNumber *)price andIsItTheMaster:(BOOL)master
{
    Variation *newVariation = [NSEntityDescription insertNewObjectForEntityForName:@"Variation" inManagedObjectContext:context];
    newVariation.master = [NSNumber numberWithBool:master];
    newVariation.name = name;
    newVariation.price = price;
    return newVariation;
}

-(void)deleteVariation:(Variation *)variation
{
    [context deleteObject:variation];
    variation = nil;
}

@end
