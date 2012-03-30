//
//  CourseDetailVewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseDetailVewController.h"
#import "GrizSpaceDataObjects.h"
#import "AppDelegateProtocol.h"

@interface CourseDetailVewController ()

@end

@implementation CourseDetailVewController
@synthesize courseIndex;


- (GrizSpaceDataObjects*) theAppDataObject
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }  
    return self;
}

/*
- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Loading course detail");
    

    [self LoadCourseDetails];
    
}

- (void)viewDidUnload
{
    courseSubjectNumber = nil;
    courseTitle = nil;
    courseDays = nil;
    courseTime = nil;
    courseRoom = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) LoadCourseDetails
{
   NSLog(@"Button %d clicked.", courseIndex);     

    CourseModel* tmpCM = [[self theAppDataObject].myCourses.myCourseItems objectAtIndex:courseIndex];
    
    if(tmpCM != nil)
    {
        courseSubjectNumber.text = [NSString stringWithFormat:@"%@ %@",tmpCM.subject, tmpCM.number];
    
        courseTitle.text = tmpCM.title;
    
        courseDays.text = [tmpCM days];
    
        courseTime.text = [tmpCM time];
    
        courseRoom.text = [tmpCM buildingAndRoom];
    }
}



@end
