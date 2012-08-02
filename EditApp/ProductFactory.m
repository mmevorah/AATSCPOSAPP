//
//  ProductFactory.m
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ProductFactory.h"
#import "Product.h"
#import "Variation.h"

@implementation ProductFactory
@synthesize context;

-(Product *)createProductShell
{
    Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext: context];    
    return newProduct;
}

@end
