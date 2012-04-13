//
//  PhotoViewController.h
//  GrizSpace
//
//  Created by William Lyon on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#include <stdlib.h> 

@interface PhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, PF_MBProgressHUDDelegate>
{
    IBOutlet UIScrollView *photoScrollView;
    NSMutableArray *allImages;
    
    PF_MBProgressHUD *HUD;
    PF_MBProgressHUD *refreshHUD;
}

- (IBAction)refresh:(id)sender;
- (IBAction)cameraButtonTapped:(id)sender;
- (void)uploadImage:(NSData *)imageData;
- (void)setUpImages:(NSArray *)images;
- (void)buttonTouched:(id)sender;

@end
