//
//  CameraOptionsViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 8/2/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@protocol CameraOptionsDelegate <NSObject>

-(void)photoFromAlbumSelected;
-(void)photoFromCameraSelected;

@end

@interface CameraOptionsViewController : UIViewController 

@property (strong, nonatomic) id<CameraOptionsDelegate>delegate;

- (IBAction)photoFromAlbum:(UIButton *)sender;
- (IBAction)photoFromCamera:(UIButton *)sender;


@end
