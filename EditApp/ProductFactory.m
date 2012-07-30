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

-(Product *)createProductWithTheName:(NSString *)name 
                            theImage:(UIImage *)image 
{
    Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext: context];    
    @try {
        if([name length] == 0)
        {
            @throw (NSString *)@"Hundred Dollah Bills ;)";
        }
    }
    @catch (NSString *exception) {
        return nil;
    }
    
    newProduct.name = name;
    newProduct.image = image;
    return newProduct;
}

@end
