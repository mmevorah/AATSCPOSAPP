//
//  FavoriteList.h
//  EditApp
//
//  Created by Mark Mevorah on 7/23/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteList : NSObject

@property(strong, nonatomic)NSMutableArray *list;
@property BOOL hidden;

-(id)init;
-(int)size;
-(void)addProductWithID:(NSNumber*)productID toPosition:(int)posNumber;
-(void)clearProductAtPosition:(int)posNumber;
@end
