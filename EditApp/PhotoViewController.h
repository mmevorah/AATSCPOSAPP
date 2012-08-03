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

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic)UIPopoverController *popOverController;

@end
