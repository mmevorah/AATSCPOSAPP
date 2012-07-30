//
//  IDManager.m
//  EditApp
//
//  Created by Mark Mevorah on 7/17/12.
//  Copyright (c) 2012 University of Michigan. All rights reserved.
//

#import "IDManager.h"

@implementation IDManager

@synthesize tempVariantIDCount;
@synthesize tempProductIDCount;
@synthesize variantIDCount;
@synthesize productIDCount;
@synthesize source;
-(id)init
{
    if(self = [super init])
    {
        //Plist Setup
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSString *plistPath = [docDir stringByAppendingPathComponent:@"productID.plist"];
        if([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            NSLog(@"[FOUND PLIST]");
            source = [NSMutableArray arrayWithContentsOfFile:plistPath];
            productIDCount = [source objectAtIndex:0];
            variantIDCount = [source objectAtIndex:1];
        }else 
        {
            NSLog(@"[COULD NO FIND PLIST] CREATING A NEW ONE");
            source = [[NSMutableArray alloc] init];
            productIDCount = [[NSNumber alloc] initWithInt:0];
            variantIDCount = [[NSNumber alloc] initWithInt:0];
            
            [source addObject:productIDCount];
            [source addObject:variantIDCount];
        }
    }
    return self;
}


-(NSNumber *)nextAvailableProductID
{
    NSNumber *nextAvailableProductID = [NSNumber numberWithInt:([tempProductIDCount intValue] + [productIDCount intValue])];
    tempProductIDCount =  [NSNumber numberWithInt:([tempProductIDCount intValue] + 1)];
    return nextAvailableProductID;
}

-(NSNumber *)nextAvailableVariantID
{
    NSNumber *nextAvailableVariantID = [NSNumber numberWithInt:([tempVariantIDCount intValue] + [variantIDCount intValue])];
    tempVariantIDCount = [NSNumber numberWithInt:([tempVariantIDCount intValue] + 1)];
    return nextAvailableVariantID;
}

-(void)saveIDS
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *plistPath = [docDir stringByAppendingPathComponent:@"productID.plist"];
    productIDCount = [NSNumber numberWithInt:([productIDCount intValue] + [tempProductIDCount intValue])];
    variantIDCount = [NSNumber numberWithInt:([variantIDCount intValue] + [tempVariantIDCount intValue])];
    tempProductIDCount = [NSNumber numberWithInt:0];
    tempVariantIDCount = [NSNumber numberWithInt:0];
    [source writeToFile:plistPath atomically:YES];
}

-(void)cancelIDS
{
    tempProductIDCount = [NSNumber numberWithInt:0];
    tempVariantIDCount = [NSNumber numberWithInt:0];
}


@end
