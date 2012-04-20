//
//  PhotoDetailViewController.h
//  GrizSpace
//
//  Created by William Lyon on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Parse/Parse.h>
#import "PhotoViewController.h"

@interface PhotoDetailViewController : UIViewController
{
    IBOutlet UIImageView *photoImageView;
    UIImage *selectedImage;
    NSString *imageName;
}
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;
@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, retain) NSString *imageName;
@property (nonatomic, strong) NSString *objectID;
@property (nonatomic, strong) PhotoViewController* hollaBack;
- (IBAction)close:(id)sender;
@end
