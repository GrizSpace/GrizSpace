//
//  PhotoViewController.m
//  GrizSpace
//
//  Created by William Lyon on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoDetailViewController.h"

@implementation PhotoViewController

#define PADDING_TOP 0 
#define PADDING 4
#define THUMBNAIL_COLS 4
#define THUMBNAIL_WIDTH 75
#define THUMBNAIL_HEIGHT 75

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Main methods

- (IBAction)refresh:(id)sender
{
    allImages = [[NSMutableArray alloc] init];
    for (UIView *subview in photoScrollView.subviews) {
        if(![subview isKindOfClass:[UIImageView class]])
            [subview removeFromSuperview];
    }
    
    NSLog(@"Showing Refresh HUD");
    refreshHUD = [[PF_MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:refreshHUD];
	
    
    refreshHUD.delegate = self;
	
    
    [refreshHUD show:YES];
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    [query whereKey:@"flags" lessThan:[NSNumber numberWithInt:3]];
    
    //PFUser *user = [PFUser currentUser];
    //[query whereKey:@"user" equalTo:user];
    //[query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            if (refreshHUD) {
                [refreshHUD hide:YES];
                
                refreshHUD = [[PF_MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:refreshHUD];
                
                refreshHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                
                refreshHUD.mode = PF_MBProgressHUDModeCustomView;
                
                refreshHUD.delegate = self;
            }
            NSLog(@"Successfully retrieved %d photos.", objects.count);
            
                  for (PFObject *eachObject in objects)
       {
           NSMutableArray *selectedPhotoArray = [[NSMutableArray alloc] init];
           [selectedPhotoArray addObject:eachObject];
           
           if (selectedPhotoArray.count > 0)
           {
               [allImages addObjectsFromArray:selectedPhotoArray];
           }
       }
            
            [self setUpImages:allImages];
        }}];
}

- (IBAction)cameraButtonTapped:(id)sender
{
    // Check for camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES) {
       
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
       
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing=YES;
        imagePicker.delegate = self;
        
    
        [self presentModalViewController:imagePicker animated:YES];
    }
    else
    
    {
        // Device has no camera
        
        NSLog(@"No camera avail!");
        // access photo library??
    }
}
- (void)uploadImage:(NSData *)imageData
{
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    HUD = [[PF_MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
   
    HUD.mode = PF_MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
   
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
           
            [HUD hide:YES];
            
         
            HUD = [[PF_MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
                       HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            
            HUD.mode = PF_MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            
            
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            [userPhoto setObject:[NSNumber numberWithInt:0] forKey:@"flags"];
            
            
            //userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            //PFUser *user = [PFUser currentUser];
            //[userPhoto setObject:user forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [self refresh:nil];
                }
                else{
                    
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        
        HUD.progress = (float)percentDone/100;
    }];
}

- (void)setUpImages:(NSArray *)images
{
    
    allImages = [images mutableCopy];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *imageDataArray = [NSMutableArray array];
        
        
        for (int i = 0; i < images.count; i++) {
            PFObject *eachObject = [images objectAtIndex:i];
            PFFile *theImage = [eachObject objectForKey:@"imageFile"];
            NSData *imageData = [theImage getData];
            UIImage *image = [UIImage imageWithData:imageData];
            [imageDataArray addObject:image];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            for (UIView *view in [photoScrollView subviews]) {
                if ([view isKindOfClass:[UIButton class]]) {
                    [view removeFromSuperview];
                }
            }
            
            
            for (int i = 0; i < [imageDataArray count]; i++) {
                PFObject *eachObject = [images objectAtIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [imageDataArray objectAtIndex:i];
                [button setImage:image forState:UIControlStateNormal];
                button.showsTouchWhenHighlighted = YES;
                [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = i;
                button.frame = CGRectMake(THUMBNAIL_WIDTH * (i % THUMBNAIL_COLS) + PADDING * (i % THUMBNAIL_COLS) + PADDING,
                                          THUMBNAIL_HEIGHT * (i / THUMBNAIL_COLS) + PADDING * (i / THUMBNAIL_COLS) + PADDING + PADDING_TOP,
                                          THUMBNAIL_WIDTH,
                                          THUMBNAIL_HEIGHT);
                button.imageView.contentMode = UIViewContentModeScaleAspectFill;
                [button setTitle:[eachObject objectId] forState:UIControlStateReserved];
                [photoScrollView addSubview:button];
            }
            
          
            int rows = images.count / THUMBNAIL_COLS;
            if (((float)images.count / THUMBNAIL_COLS) - rows != 0) {
                rows++;
            }
            int height = THUMBNAIL_HEIGHT * rows + PADDING * rows + PADDING + PADDING_TOP;
            
            photoScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
            photoScrollView.clipsToBounds = YES;
        });
    });
}

- (void)buttonTouched:(id)sender {
    
    
    NSLog(@"buttonTouched method");
    
    PFObject *theObject = (PFObject *)[allImages objectAtIndex:[sender tag]];
    PFFile *theImage = [theObject objectForKey:@"imageFile"];
    
    NSData *imageData;
    imageData = [theImage getData];
    UIImage *selectedPhoto = [UIImage imageWithData:imageData];
    
    PhotoDetailViewController *pdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoDetailViewController"];
    
    pdvc.selectedImage = selectedPhoto;
    pdvc.objectID = [theObject objectId];
    [self presentModalViewController:pdvc animated:YES];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refresh:nil];
    
   // allImages = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
   
    [picker dismissModalViewControllerAnimated:YES];
    
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();   
    
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    [self uploadImage:imageData];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(PF_MBProgressHUD *)hud {
    
    [HUD removeFromSuperview];
	HUD = nil;
}

@end
