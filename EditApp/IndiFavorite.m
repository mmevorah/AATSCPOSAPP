//
//  IndiFavorite.m
//  EditApp
//
//  Created by Mark Mevorah on 8/6/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "IndiFavorite.h"

@implementation IndiFavorite

@synthesize productID;
@synthesize list;
@synthesize position;

- (id)initWithPosition:(NSInteger*)positionNumber;
{
    if(self = [super init])
    {
        self = [UIButton buttonWithType:UIButtonTypeCustom];
    }
        
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
