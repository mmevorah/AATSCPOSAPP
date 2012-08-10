//
//  IndiFavorite.h
//  EditApp
//
//  Created by Mark Mevorah on 8/6/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndiFavorite : UIButton
{
}
@property (strong, nonatomic) NSNumber *productID;
@property NSInteger list;
@property NSInteger position;
@property (strong, nonatomic) UILabel *label;

@end
