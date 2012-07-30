//
//  ProductTableDataSource.h
//  EditApp
//
//  Created by Mark Mevorah on 7/25/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;
@interface ProductTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *products;
}

-(void)setProducts:(NSArray *)newProducts;
- (Product *)productForIndexPath:(NSIndexPath *)indexPath;

@end

extern NSString *ProductTableDidSelectProductNotification;