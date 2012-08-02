//
//  EditManager.h
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;
@class Variation;
@class ProductFactory;
@class VariationFactory;
@class IDManager;
@class Favorites;
@class FavoritesManager;



@interface EditManager : NSObject
{
}

@property(strong, nonatomic) ProductFactory *productFactory;
@property(strong, nonatomic) VariationFactory *variationFactory;
@property(strong, nonatomic) IDManager *idManager;
@property(strong, nonatomic) FavoritesManager *favoriteManager;
@property(strong, nonatomic) NSManagedObjectContext *context;


//set up
-(id)initWithManagedObjectContext:(NSManagedObjectContext*)setContext andIDManager:(IDManager *)setIDManager;

//product and variation creation
-(Product*)createProductWithAName:(NSString *)name anImage:(UIImage*)image andAPrice:(NSNumber *)price;
-(void)addVariationToProduct:(Product *)product withName:(NSString *)name andPrice:(NSNumber *)price;

-(Variation*)getMasterVariationFromProduct:(Product*)product;

//product and variation deletion
-(void)deleteVariation:(Variation *)variation inProduct:(Product *)product;
-(void)deleteProduct:(Product *)product;

//modification
-(void)changeProduct:(Product*)product nameTo:(NSString *)name;
-(void)changeProduct:(Product*)product imageTo:(UIImage *)image;
-(void)changeProduct:(Product*)product masterPriceTo:(NSNumber*)price;
-(void)changeVariation:(Variation *)variation nameTo:(NSString *)name;
-(void)changeVariation:(Variation *)variation priceTo:(NSNumber *)price;

//saving and cancelling
-(void)saveContext;
-(void)cancelContext;

//Accessing
-(NSArray*)getProductList;
-(NSArray*)getVariationListFromProduct:(Product*)product;

//Utility
-(NSNumber*)convertCurrencyToNumber:(NSString*)string;

-(void)addProductToFavoritesWithID:(NSNumber*)productID toFavoritesList:(int)favList atPosition:(NSNumber*)pos;
-(void)removeProductFromFavoritesList:(int)favList position:(NSNumber*)pos;
-(NSNumber *)numberOfActiveFavorites;

@end
