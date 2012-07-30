//
//  VariationFactory.h
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Variation;
@class Product;

@interface VariationFactory : NSObject

@property(strong, nonatomic) NSManagedObjectContext *context;

-(Variation *)createVariationWithTheName:(NSString *)name thePrice:(NSNumber *)price andIsItTheMaster:(BOOL)master;
-(void)deleteVariation:(Variation *)variation;

@end
