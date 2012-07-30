//
//  IDManager.h
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDManager : NSObject
{
    NSNumber *tempProductIDCount;
    NSNumber *tempVariantIDCount;
    NSNumber *productIDCount;
    NSNumber *variantIDCount;
}

@property(strong, nonatomic) NSNumber *tempProductIDCount;
@property(strong, nonatomic) NSNumber *tempVariantIDCount;
@property(strong, nonatomic) NSNumber *productIDCount;
@property(strong, nonatomic) NSNumber *variantIDCount;
@property(strong, nonatomic) NSMutableArray *source;


-(id)init;
-(NSNumber *)nextAvailableProductID;
-(NSNumber *)nextAvailableVariantID;

-(void)saveIDS;
-(void)cancelIDS;

@end
