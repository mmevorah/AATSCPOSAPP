//
//  DragableView.m
//  EditApp
//
//  Created by Mark Mevorah on 8/7/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "DragableView.h"

@implementation DragableView

@synthesize imageView;
@synthesize label;
@synthesize product;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        mainView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 100, 120)];
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.layer.cornerRadius = 8;
        mainView.layer.masksToBounds = YES;
        [self addSubview:mainView];
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = CGRectMake(5, 5, 90, 90);
        self.imageView.layer.cornerRadius = 3;
        self.imageView.layer.masksToBounds = YES;
        self.label = [[UILabel alloc] init];
        self.label.frame = CGRectMake(5, 98, 90, 15);
        self.label.text = @"Product Name";
        self.label.textAlignment = NSTextAlignmentCenter;
        [mainView addSubview:self.label];
        [mainView addSubview:self.imageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    // Drawing code
}

@end
