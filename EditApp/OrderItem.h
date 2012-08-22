//
//  OrderItem.h
//  EditApp
//
//  Created by Mark Mevorah on 8/22/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order;

@interface OrderItem : NSManagedObject

@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * productID;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSNumber * variationID;
@property (nonatomic, retain) Order *order;

@end
