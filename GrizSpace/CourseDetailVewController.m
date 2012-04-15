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
@property (strong, nonatomic) IBOutlet UIButton *studyBuddyButton;

@end

@implementation CourseDetailVewController
@synthesize studyBuddyButton;
@synthesize courseIndex;
@synthesize selectedCourse;
@synthesize courseDelegate;
@synthesize studyBuddySwitch;
@synthesize delegate;
- (IBAction)showStudyBuddy:(id)sender 
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"CourseModel"];
    [query whereKey:@"number" equalTo:[self.selectedCourse number]];
    [query whereKey:@"subject" equalTo:[self.selectedCourse subject]];
    [query whereKey:@"studyBuddy" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"userid" notEqualTo:[[UIDevice currentDevice] uniqueIdentifier]];
    PFObject* queryResults = [query getFirstObject];
    
    if (!queryResults) 
    
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Buddies" message:@"I'm sorry but there are not study buddies available for this course" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    
    else 
    {
        NSString* buddyName = [queryResults objectForKey:@"userName"];
        
        NSString* buddyEmail = [queryResults objectForKey:@"userEmail"];
        
        NSString *mesg = [[NSString alloc] initWithFormat:@"Your study buddy is %@ at %@", buddyName, buddyEmail];
    
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
    
    if (!studyBuddySwitch.isOn)
    {
        studyBuddyButton.enabled=NO;
    }
    
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
    [self setStudyBuddySwitch:nil];
    [self setStudyBuddyButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (IBAction)findItAction:(id)sender {
    
    

    //else {
        //sets the correct tab index
        [self.tabBarController setSelectedIndex:0];
        
        //get handle for nav controller
        UINavigationController *tmpNC = [self.tabBarController.viewControllers objectAtIndex:0];
        
        //get handle for map view controller
        MapViewController *mView = [tmpNC.viewControllers objectAtIndex:0];
        
        //set the appropriate delegate for the action
        self.delegate = mView;
        
        //call delegate action to display the building index
        [delegate showCourseAnnotation: selectedCourse]; 
    
    if (self.tabBarController.selectedIndex == 0) {
        [[self navigationController] popViewControllerAnimated:YES];
        
    }
    //}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) LoadCourseDetails
{
   NSLog(@"Button %d clicked.", courseIndex);     

   // CourseModel* tmpCM = [[self theAppDataObject].myCourses.myCourseItems objectAtIndex:courseIndex];
    CourseModel *tmpCM = [self selectedCourse];
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
    [CourseList removeCourse:self.selectedCourse];
    

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


- (IBAction)didToggleStudyBuddySwitch:(id)sender 
{
 
if (studyBuddySwitch.isOn)
{
    UIAlertView *namePrompt = [[UIAlertView alloc] initWithTitle:@"Study Buddy Contact Info" message:@"Please enter your name" delegate:nil cancelButtonTitle:@"Cancel " otherButtonTitles:@"Okay", nil];
    namePrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ModalAlertDelegate *delegate = [ModalAlertDelegate delegateWithAlert:namePrompt];
    
    NSString *userName = @"";
    if ([delegate show])
        userName = [NSString stringWithFormat: [namePrompt textFieldAtIndex:0].text];
    
    
    UIAlertView *emailPrompt = [[UIAlertView alloc] initWithTitle:@"Study Buddy Contact Info" message:@"Please enter your email address" delegate:nil cancelButtonTitle:@"Cancel " otherButtonTitles:@"Okay", nil];
    emailPrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ModalAlertDelegate *delegate2 = [ModalAlertDelegate delegateWithAlert:emailPrompt];
    
    NSString *userEmail = @"";
    if ([delegate2 show])
        userEmail = [NSString stringWithFormat: [emailPrompt textFieldAtIndex:0].text];
    
    [studyBuddyButton setEnabled:YES];
    [CourseList setStuddyBuddy:selectedCourse withUserName:userName withEmail:userEmail];
}
else 
{
    [studyBuddyButton setEnabled:NO];
    [CourseList setStuddyBuddyNo:selectedCourse];
    
}

}
@end
