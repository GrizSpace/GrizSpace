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
@synthesize selectedCourse;
@synthesize courseDelegate;

- (IBAction)showStudyBuddy:(id)sender 
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"CourseModel"];
    [query whereKey:@"number" equalTo:[self.selectedCourse number]];
    [query whereKey:@"subject" equalTo:[self.selectedCourse subject]];
    [query whereKey:@"userid" notEqualTo:[[UIDevice currentDevice] uniqueIdentifier]];
    PFObject* queryResults = [query getFirstObject];
    
    if (!queryResults) 
    
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Buddies" message:@"I'm sorry but there are not study buddies available for this course" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
    else 
    {
        NSString* buddyID = [queryResults objectForKey:@"userid"];
        
        NSString *mesg = [[NSString alloc] initWithFormat:@"Your study buddy is %@", buddyID];
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Study Buddy" message:mesg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    }

}
- (IBAction)selectCancel:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];

}

-(void) didReceiveCourse:(id)selectedCourseFromPicker
{
    selectedCourse = selectedCourseFromPicker;
}

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
    
    NSLog(@"Your selected course is: %@", self.selectedCourse.number);
    
    

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
        //courseSubjectNumber.text = [NSString stringWithFormat:@"%@ %@",tmpCM.subject, tmpCM.number];
    
        courseSubjectNumber.text = [NSString stringWithFormat:@"%@ %@", selectedCourse.subject, selectedCourse.number];
        
        //courseTitle.text = tmpCM.title;
    
        courseTitle.text = @"We need some course titles in the db";
        
        //courseDays.text = [tmpCM days];
        courseDays.text = [NSString stringWithFormat:@"%@", selectedCourse.section.getDays];
        //courseTime.text = [tmpCM time];
        courseTime.text = [NSString stringWithFormat:@"%@:%@", selectedCourse.section.startTime, selectedCourse.section.endTime];
        
        //courseRoom.text = [tmpCM buildingAndRoom];
        
        courseRoom.text = [NSString stringWithFormat:@"%@ %@", selectedCourse.section.building, selectedCourse.section.room];
    }
}

- (IBAction)removeCourseButton:(id)sender 
{
   // [CourseList removeCourse:self.selectedCourse];
    

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
            
        if ([[segue identifier] isEqualToString:@"justRemovedACourse"])
        {
             [CourseList removeCourse:self.selectedCourse];
            [[segue destinationViewController] viewDidLoad];
           // [[segue destinationViewController].tableView reloadData]];
            
            
        }
        
    
}


@end
