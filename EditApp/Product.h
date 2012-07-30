//
//  Product.h
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Variation;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSNumber * iD;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *variation;

-(NSNumber *)masterPrice;

@end

@interface Product (CoreDataGeneratedAccessors)

- (void)addVariationObject:(Variation *)value;
- (void)removeVariationObject:(Variation *)value;
- (void)addVariation:(NSSet *)values;
- (void)removeVariation:(NSSet *)values;


@end
