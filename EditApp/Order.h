//
//  Order.h
//  EditApp
//
//  Created by Mark Mevorah on 8/22/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OrderItem;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSDate * name;
@property (nonatomic, retain) NSNumber * totalPrice;
@property (nonatomic, retain) NSSet *orderItem;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addOrderItemObject:(OrderItem *)value;
- (void)removeOrderItemObject:(OrderItem *)value;
- (void)addOrderItem:(NSSet *)values;
- (void)removeOrderItem:(NSSet *)values;

@end
