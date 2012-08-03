//
//  PhotoViewController.m
//  EditApp
//
//  Created by Mark Mevorah on 8/3/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

@synthesize album;
@synthesize camera;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(album == TRUE)
    {
        
    }else if(camera == TRUE)
    {
        if([self doesCameraSupportTakingPhotos])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
            imagePicker.allowsEditing = NO;
            imagePicker.navigationBarHidden = TRUE;
            [self presentModalViewController:imagePicker animated:YES];
        }else
        {
            NSLog(@"Camera is not supported");
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}

-(BOOL)cameraSupportsMedia:(NSString*)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    
    if([paramMediaType length] == 0)
    {
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if([mediaType isEqualToString:paramMediaType])
        {
            result = YES;
            *stop = YES;
        }
    } ];
    return result;
}

-(BOOL)doesCameraSupportTakingPhotos
{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie
                          sourceType:UIImagePickerControllerSourceTypeCamera];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
