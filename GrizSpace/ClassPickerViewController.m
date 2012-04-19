//
//  ClassPickerViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassPickerViewController.h"

@interface ClassPickerViewController ()

@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *daysLabel;
@property (strong, nonatomic) IBOutlet UILabel *timesLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectSectionButton;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ClassPickerViewController

@synthesize subjectLabel;
@synthesize daysLabel;
@synthesize timesLabel;
@synthesize locationLabel;
@synthesize selectSectionButton;
@synthesize titleLabel;
@synthesize coursePicker;
@synthesize selectCourseButton;
@synthesize selectedSubject;
@synthesize selectedCourse = _selectedCourse;
@synthesize addButton;
@synthesize delegate;
@synthesize receivedSection;

-(void) didReceiveCourse:(CourseModel *)selectedCourseFromPicker
{
    [self setSelectedCourse:selectedCourseFromPicker];
}

-(void) didReceiveSection:(CourseSection *)selectedSectionFromPicker
{
    self.selectedCourse.section = selectedSectionFromPicker;
    daysLabel.text = self.selectedCourse.section.getDays;
    timesLabel.text = [NSString stringWithFormat:@"%@: %@", self.selectedCourse.section.startTime, self.selectedCourse.section.endTime];
    
    locationLabel.text = [NSString stringWithFormat:@"%@ %@", self.selectedCourse.section.building, self.selectedCourse.section.room];
    selectSectionButton.titleLabel.text = self.selectedCourse.section.getNumberString;
    
}
-(void) setReceivedSection:(CourseSection *)receivedSection
{
    [self.selectedCourse setSection:receivedSection];
    daysLabel.text = self.selectedCourse.section.getDays;
    timesLabel.text = [NSString stringWithFormat:@"%@: %@", self.selectedCourse.section.startTime, self.selectedCourse.section.endTime];
    
    locationLabel.text = [NSString stringWithFormat:@"%@ %@", self.selectedCourse.section.building, self.selectedCourse.section.room];
    titleLabel.text = self.selectedCourse.section.courseTitle;
    selectSectionButton.titleLabel.text = self.selectedCourse.section.getNumberString;
}

-(void)setSelectedCourse:(CourseModel *)selectedCourse
{
    _selectedCourse = selectedCourse;
    
    selectCourseButton.titleLabel.text = selectedCourse.number;
}
- (IBAction)addToCourseList:(id)sender 
{
    
    [CourseList addCourse: self.selectedCourse inSubject: selectedSubject];
    
    
}



- (IBAction)FindItAction:(id)sender {
    
    //sets the correct tab index
    [self.tabBarController setSelectedIndex:0];
    
    //get handle for nav controller
    UINavigationController *tmpNC = [self.tabBarController.viewControllers objectAtIndex:0];
    
    //get handle for map view controller
    MapViewController *mView = [tmpNC.viewControllers objectAtIndex:0];
    
    //set the appropriate delegate for the action
    self.delegate = mView;
    
    //call delegate action to display the building index
    [delegate showCourseAnnotation: _selectedCourse];  
}


//-(void) setSelectedSubject:(SubjectModel *)selectedSubject
//{
//    _selectedSubject = selectedSubject;
  //  self.subjectLabel.text = self.selectedSubject.abbr;
//}

-(IBAction)showCoursesToSelect:(id)sender
{
    SelectCourseTableViewController *selectView = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCourseTableViewController"];
    
    [selectView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    selectView.delegate = self;
    
    
    [selectView setSelectedSubject:selectedSubject];

    
   // [self.navigationController presentModalViewController:selectView animated:YES];
    [self.navigationController pushViewController:selectView animated:YES];
}
- (IBAction)showSectionsToSelect:(id)sender 
{

    SelectSectionTableViewController *selectView = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectSectionTableViewController"];
    
    [selectView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    selectView.sectiondelegate = self;
    
    [selectView setSelectedCourse:self.selectedCourse];
    
    //[self.navigationController presentModalViewController:selectView animated:YES];
    [self.navigationController pushViewController:selectView animated:YES];
}



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
    selectCourseButton.enabled=NO;
    selectSectionButton.enabled=NO;
    self.subjectLabel.text = self.selectedSubject.abbr;
    selectCourseButton.titleLabel.text = self.selectedCourse.number;
    daysLabel.text = self.selectedCourse.section.getDays;
    timesLabel.text = [NSString stringWithFormat:@"%@: %@", self.selectedCourse.section.startTime, self.selectedCourse.section.endTime];
    
    locationLabel.text = [NSString stringWithFormat:@"%@ %@", self.selectedCourse.section.building, self.selectedCourse.section.room];
    selectSectionButton.titleLabel.text = self.selectedCourse.section.getNumberString;
    titleLabel.text = self.selectedCourse.section.courseTitle;

    
    
}

- (void)viewDidUnload
{
    [self setCoursePicker:nil];
    
    [self setSelectCourseButton:nil];
    [self setSubjectLabel:nil];
    [self setAddButton:nil];
    [self setDaysLabel:nil];
    [self setTimesLabel:nil];
    [self setLocationLabel:nil];
    [self setSelectSectionButton:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
