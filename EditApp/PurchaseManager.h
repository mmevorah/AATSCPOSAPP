//
//  PurchaseManager.h
//  EditApp
//
//  Created by Mark Mevorah on 8/22/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Order;
@class EditManager;

@interface PurchaseManager : NSObject
{
    EditManager *editManager;
    Order *order;
}

@property(strong, nonatomic) Order *order;

-(id)initWithEditManager:(EditManager*)editManager;
-(EditManager*)getEditManager;

-(void)createNewOrder;
-(void)addProductWithID:(NSNumber*)productID andVariation:(NSNumber*)variationID;
-(void)removeProductWithID:(NSNumber*)productID andVariation:(NSNumber*)variationID;
-(void)placeOrder;
-(NSArray*)getOrderHistoryList;

@end
