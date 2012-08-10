//
//  EditManager.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "EditManager.h"
#import "ProductFactory.h"
#import "VariationFactory.h"
#import "Product.h"
#import "Variation.h"
#import "IDManager.h"
#import "AppDelegate.h"
#import "FavoritesManager.h"
#import "FavoriteList.h"

@implementation EditManager

@synthesize productFactory;
@synthesize variationFactory;
@synthesize idManager;
@synthesize context;
@synthesize favoriteManager;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)setContext andIDManager:(IDManager *)setIDManaged
{
    if(self = [super init])
    {
        productFactory = [[ProductFactory alloc] init];
        variationFactory = [[VariationFactory alloc] init];
        productFactory.context = setContext;
        variationFactory.context = setContext;
        
        context = setContext;
        idManager = setIDManaged;
    }
    return self;    
}

-(Product*)createProductShell
{
    Product *newProduct = [productFactory createProductShell];
    Variation *newVariation = [variationFactory createVariationWithTheName:@"Regular" thePrice:[NSNumber numberWithDouble:-3.111] andIsItTheMaster:YES];
    newProduct.iD = [idManager nextAvailableProductID];
    newVariation.iD = [idManager nextAvailableVariantID];
    [newProduct addVariationObject:newVariation];
    return newProduct;
}

-(void)addVariationToProduct:(Product *)product withName:(NSString *)name andPrice:(NSNumber *)price
{
    Variation *newVariation = [variationFactory createVariationWithTheName:name thePrice:price andIsItTheMaster:NO];
    newVariation.iD = [idManager nextAvailableVariantID];
        
    [product addVariationObject:newVariation];
}

-(void)deleteProduct:(Product *)product
{
    if([self productIsAFavorite:product])
    {
        for(int i = 0; i < 25; i++)
        {
            if([product.iD integerValue] == [[favoriteManager.favList0.list objectAtIndex:i] integerValue])
            {
                [self removeProductFromFavoritesList:0 position:[NSNumber numberWithInt:i]];
            }else if([product.iD integerValue] == [[favoriteManager.favList1.list objectAtIndex:i] integerValue])
            {
                [self removeProductFromFavoritesList:1 position:[NSNumber numberWithInt:i]];
            }else if([product.iD integerValue] == [[favoriteManager.favList2.list objectAtIndex:i] integerValue])
            {
                [self removeProductFromFavoritesList:2 position:[NSNumber numberWithInt:i]];
            }else if([product.iD integerValue] == [[favoriteManager.favList3.list objectAtIndex:i] integerValue])
            {
                [self removeProductFromFavoritesList:3 position:[NSNumber numberWithInt:i]];
            }else if([product.iD integerValue] == [[favoriteManager.favList4.list objectAtIndex:i] integerValue])
            {
                [self removeProductFromFavoritesList:4 position:[NSNumber numberWithInt:i]];
            }
        }
    }
    [context deleteObject:product];
}

-(void)deleteVariation:(Variation *)variation inProduct:(Product *)product
{
    NSArray *array = [self arrangeVariants:product.variation];          //have a sorted array
    if((product.variation.count - 1) != 0)
    {
        if([variation.master boolValue] == YES)
        {
            Variation *aVariation = [array objectAtIndex:1];
            aVariation.master = [NSNumber numberWithBool: YES];
            NSLog(@"aVariation is: %@", aVariation.master);
        }
        [product removeVariationObject:variation];
        [context deleteObject:variation];
    }
}

-(NSArray *)arrangeVariants:(NSSet *)set
{
    NSMutableArray *arranged = [[NSMutableArray alloc] initWithArray:set.allObjects];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"iD" ascending:YES];
    [arranged sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
    return arranged;
}

-(void)changeProduct:(Product *)product nameTo:(NSString *)name
{
    product.name = name;
}

-(void)changeProduct:(Product *)product imageTo:(UIImage *)image
{
    product.image = image;
}

-(void)changeProduct:(Product *)product masterPriceTo:(NSNumber *)price
{
    [self changeVariation:[self getMasterVariationFromProduct:product] priceTo:price];
}

-(void)changeVariation:(Variation *)variation nameTo:(NSString *)name
{
    variation.name = name;
}

-(void)changeVariation:(Variation *)variation priceTo:(NSNumber *)price
{
    variation.price = price;
}

-(void)addProductToFavoritesWithID:(NSNumber *)productID toFavoritesList:(int)favList atPosition :(NSNumber *)pos
{
    [favoriteManager insertProductWithID:productID intoFavoritesList:favList atPosition: [pos intValue]];
    [favoriteManager saveFavorites];
}

-(void)removeProductFromFavoritesList:(int)favList position:(NSNumber *)pos
{
    [favoriteManager removeProductFromList:favList atPostion: [pos intValue]];
    [favoriteManager saveFavorites];
}

-(NSNumber*)convertCurrencyToNumber:(NSString *)string
{
    NSString *stringWithoutCurrencySymbol = [string stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return [NSNumber numberWithDouble: [[stringWithoutCurrencySymbol stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue]];
}


-(void)cleanUpVariationListForProduct:(Product *)product
{
    /*
    int i = 0;
    while(i < [[self getVariationListFromProduct:product] count])
    {
        NSString *name = [[[self getVariationListFromProduct:product] objectAtIndex:i] name];
        if([name isEqualToString:@""] || (name == nil))
        {
            [self deleteVariation:[[self getVariationListFromProduct:product] objectAtIndex:i] inProduct: product];
            i--;
        }
        i++;
    }*/
}

-(void)saveContext
{
    AppDelegate *theDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [theDelegate saveContext];
    [idManager saveIDS];
}

-(void)cancelContext
{
    [context rollback];
    [idManager cancelIDS];
}

-(NSArray*)getProductList:(NSString*)searchTerm
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
    [request setEntity:productEntity];

    if(searchTerm != nil)
    {
        NSPredicate *productPredicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchTerm];
        [request setPredicate:productPredicate];
    }
    
    NSError *error;
    NSArray *adiPure = [context executeFetchRequest:request error:&error];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    return [adiPure sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
}

-(NSArray*)getVariationListFromProduct:(Product *)product
{
    NSArray *array = [[product variation] allObjects];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"iD" ascending:YES];
    return [array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sort, nil]];
}

-(Product*)productFromID:(NSNumber *)productID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"iD = %@", productID];
    [fetchRequest setPredicate:predicate];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Product"  inManagedObjectContext:context];
    [fetchRequest setEntity:entityDescription];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    NSLog(@"the array looks like: %@", results);
    
    if(results.count > 0)
    {
        return [results objectAtIndex:0];
    }else
    {
        return nil;
    }
}

-(NSNumber *)numberOfActiveFavorites
{
    int count = 0;
    if([self contentsOfArray:self.favoriteManager.favList0.list] == TRUE)
    {
        count++;
    }
    if([self contentsOfArray:self.favoriteManager.favList1.list] == TRUE)
    {
        count++;
    }
    if([self contentsOfArray:self.favoriteManager.favList2.list] == TRUE)
    {
        count++;
    }
    if([self contentsOfArray:self.favoriteManager.favList3.list] == TRUE)
    {
        count++;
    }
    if([self contentsOfArray:self.favoriteManager.favList4.list] == TRUE)
    {
        count++;
    }
    return [NSNumber numberWithInt:count];
}

-(Variation*)getMasterVariationFromProduct:(Product *)product
{
    NSArray *variations = [NSArray arrayWithArray: product.variation.allObjects];
    for(int i = 0; i < product.variation.count ; i++)
    {
        if([[[variations objectAtIndex:i] master] boolValue] == YES)
        {
            return [variations objectAtIndex:i];
        }
    }
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Could'nt Find Master Variation" delegate:nil cancelButtonTitle:@"Darn!"otherButtonTitles:nil, nil];
    [error show];
    return nil;
}

-(bool)contentsOfArray:(NSArray*)array
{
    for(int i = 0; i < 25; i++)
    {
        if([[array objectAtIndex:i] intValue] != -1)
        {
            return TRUE;
        }
    }
    return FALSE;
}

-(int)getNextAvailablePositionFromFavoritesList:(int)favoritesListNumber
{
    FavoriteList *favoriteList;
    if(favoritesListNumber == 0)
    {
        favoriteList = favoriteManager.favList0;
    }else if(favoritesListNumber == 1)
    {
        favoriteList = favoriteManager.favList1;
    }else if(favoritesListNumber == 2)
    {
        favoriteList = favoriteManager.favList2;
    }else if(favoritesListNumber == 3)
    {
        favoriteList = favoriteManager.favList3;
    }else if(favoritesListNumber == 4)
    {
        favoriteList = favoriteManager.favList4;
    }
    for(int i = 0; i < 25; i++)
    {
        if([[favoriteList.list objectAtIndex:i] integerValue] == -1)
        {
            return i;
        }
    }
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No more room in this list" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil, nil];
    [error show];
    return -1;
}

-(bool)productIsAFavorite:(Product*)product;
{
    for(int i = 0; i < 25; i++)
    {
        if([product.iD integerValue] == [[favoriteManager.favList0.list objectAtIndex:i] integerValue])
        {
            return TRUE;
        }else if([product.iD integerValue] == [[favoriteManager.favList1.list objectAtIndex:i] integerValue])
        {
            return TRUE;
        }else if([product.iD integerValue] == [[favoriteManager.favList2.list objectAtIndex:i] integerValue])
        {
            return TRUE;
        }else if([product.iD integerValue] == [[favoriteManager.favList3.list objectAtIndex:i] integerValue])
        {
            return TRUE;
        }else if([product.iD integerValue] == [[favoriteManager.favList4.list objectAtIndex:i] integerValue])
        {
            return TRUE;
        }
    }
    return FALSE;
}

@end
