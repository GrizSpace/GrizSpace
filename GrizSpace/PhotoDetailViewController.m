//
//  PhotoDetailViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoDetailViewController.h"

@implementation PhotoDetailViewController
@synthesize photoImageView, selectedImage, imageName, objectID, hollaBack;

- (IBAction)flag:(id)sender 
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFObject *flagedPhoto = [query getObjectWithId:self.objectID];
    
    if ([[flagedPhoto objectForKey:@"flags"] intValue] > 1)
    {
        [flagedPhoto incrementKey:@"flags"];
        [flagedPhoto save];
        [hollaBack refresh:nil];
        [self dismissModalViewControllerAnimated:YES];
    }
    else 
    {
        
    
    [flagedPhoto incrementKey:@"flags"];
    [flagedPhoto save];
    }
}

- (IBAction)close:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
   
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoImageView.image = selectedImage;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
