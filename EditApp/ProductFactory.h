//
//  ProductFactory.h
//  EditApp
//
//  Created by Mark Mevorah on 7/16/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@class Variation;
@class VariationFactory;

@interface ProductFactory : NSObject

@property(strong, nonatomic) NSManagedObjectContext *context;

-(Product *)createProductWithTheName:(NSString *)name 
                            theImage:(UIImage *)image;

@end
