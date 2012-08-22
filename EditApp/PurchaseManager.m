//
//  PurchaseManager.m
//  EditApp
//
//  Created by Mark Mevorah on 8/22/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "PurchaseManager.h"
#import "EditManager.h"
#import "Order.h"
#import "OrderItem.h"
#import "Product.h"
#import "Variation.h"

@implementation PurchaseManager

@synthesize order;

-(id)initWithEditManager:(EditManager *)carriedEditManager
{
    if(self = [super init])
    {
        editManager = carriedEditManager;
    }
    return self;
}

-(EditManager*)getEditManager
{
    return editManager;
}

-(void)createNewOrder
{
    order = [NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:editManager.context];;
}

-(BOOL)itemRepeatedWithProductID:(NSNumber *)productID andVariation:(NSNumber *)variationID
{
    NSArray *items = [order.orderItem allObjects];
    for(int i = 0; i < [items count]; i++)
    {
        OrderItem *item = [items objectAtIndex:i];
        int itemProductID = [[item productID] intValue];
        int itemVariationID = [[item variationID] intValue];
        int carriedProductID = [productID intValue];
        int carriedVariationID = [variationID intValue];
        
        if((itemProductID == carriedProductID) && (itemVariationID == carriedVariationID))
        {
            return TRUE;
        }
    }
    return FALSE;
}

-(OrderItem*)orderItemFromProductID:(NSNumber*)productID andVariation:(NSNumber*)variationID
{
    NSArray *items = [order.orderItem allObjects];
    OrderItem *orderItem;
    for(int i = 0; i < [items count]; i++)
    {
        OrderItem *item = [items objectAtIndex:i];
        int itemProductID = [[item productID] intValue];
        int itemVariationID = [[item variationID] intValue];
        int carriedProductID = [productID intValue];
        int carriedVariationID = [variationID intValue];
        if((itemProductID == carriedProductID) && (itemVariationID == carriedVariationID))
        {
            orderItem = item;
        }
    }
    return orderItem;
}

-(void)addProductWithID:(NSNumber *)productID andVariation:(NSNumber *)variationID
{
    BOOL itemIsARepeat = [self itemRepeatedWithProductID:productID andVariation:variationID];
    if(itemIsARepeat == TRUE)
    {
        NSLog(@"repeated");
        OrderItem *item = [self orderItemFromProductID:productID andVariation:variationID];
        item.quantity = [NSNumber numberWithInt:([item.quantity intValue] + 1)];
        order.totalPrice = [NSNumber numberWithInt:([order.totalPrice intValue] + [item.price intValue])];
    }
    else
    {
        NSLog(@"not repeated");
        OrderItem *orderItem = [NSEntityDescription insertNewObjectForEntityForName:@"OrderItem" inManagedObjectContext:editManager.context];
        orderItem.order = order;
        orderItem.quantity = [NSNumber numberWithInt:1];
        orderItem.productID = productID;
        orderItem.variationID = variationID;
        
        Product *product = [editManager productFromID:productID];
        NSArray *variations = [product.variation allObjects];
        for(int i = 0; i < [variations count]; i++)
        {
            if([[[variations objectAtIndex:i] iD] intValue] == [variationID intValue])
            {
                orderItem.price = [[variations objectAtIndex:i] price];
                order.totalPrice = [NSNumber numberWithInt:([order.totalPrice intValue] + [orderItem.price intValue])];
            }
        }
    }
}

-(void)removeProductWithID:(NSNumber *)productID andVariation:(NSNumber *)variationID
{
    OrderItem *item = [self orderItemFromProductID:productID andVariation:variationID];
    if(item.quantity.intValue > 1)
    {
        item.quantity = [NSNumber numberWithInt:(item.quantity.intValue - 1)];
    }else
    {
        [order removeOrderItemObject:item];
    }
    order.totalPrice = [NSNumber numberWithInt:(order.totalPrice.doubleValue - item.price.doubleValue)];
}

-(void)placeOrder
{
    order.name = [NSDate date];
    [editManager saveContext];
    order = nil;
    [self createNewOrder];
}

-(NSArray*)getOrderHistoryList
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *orderEntity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:[editManager context]];
    [request setEntity:orderEntity];
    NSError *error;
    NSArray *adiPure = [editManager.context executeFetchRequest:request error:&error];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[adiPure sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]] ];
    [mutableArray removeObjectAtIndex:0];
    adiPure = [NSArray arrayWithArray:mutableArray];
    return adiPure;
}


@end
