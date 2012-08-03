//
//  PhotoViewController.h
//  EditApp
//
//  Created by Mark Mevorah on 8/3/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property BOOL album;
@property BOOL camera;

@end
