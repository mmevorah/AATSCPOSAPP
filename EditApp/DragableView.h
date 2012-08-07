//
//  DragableView.h
//  EditApp
//
//  Created by Mark Mevorah on 8/7/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragableView : UIView
{
    UIView *mainView;
}
@property(strong, nonatomic)UIImageView *imageView;
@property(strong, nonatomic)UILabel *label;
@end
