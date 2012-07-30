//
//  ProductTableDataSource.m
//  EditApp
//
//  Created by Mark Mevorah on 7/25/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "ProductTableDataSource.h"
#import "Product.h"

NSString *productCellReuseIdentifier = @"Topic";

@implementation ProductTableDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSParameterAssert(section == 0);
    return [products count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert([indexPath section] == 0);
    NSParameterAssert([indexPath row] < [products count]);
    UITableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:productCellReuseIdentifier];
    if(!productCell)
    {
        productCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellReuseIdentifier];
    }
    productCell.textLabel.text = [[products objectAtIndex:[indexPath row]] name];
    return productCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotification *note = [NSNotification notificationWithName:ProductTableDidSelectProductNotification object:[self productForIndexPath: indexPath]];
    [[NSNotificationCenter defaultCenter] postNotification:note];
}

-(void)setProducts:(NSArray *)newProducts
{
    products = newProducts;
}

- (Product *)productForIndexPath: (NSIndexPath *)indexPath
{
    return [products objectAtIndex:[indexPath row]];
}

@end

NSString *ProductTableDidSelectProductNotification = @"ProductTableDidSelectProductNotification";
