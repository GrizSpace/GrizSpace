//
//  ClassPickerViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassPickerViewController.h"

@interface ClassPickerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;

@end

@implementation ClassPickerViewController
@synthesize tf2;
@synthesize subjectLabel;
@synthesize coursePicker;
@synthesize selectCourseButton;
@synthesize selectedSubject;
@synthesize selectedCourse = _selectedCourse;
@synthesize addButton;

-(void) didReceiveCourse:(CourseModel *)selectedCourseFromPicker
{
    [self setSelectedCourse:selectedCourseFromPicker];
    NSLog(@"Selecte course title: %@", self.selectedCourse.title);
}

-(void)setSelectedCourse:(CourseModel *)selectedCourse
{
    _selectedCourse = selectedCourse;
    
    selectCourseButton.titleLabel.text = selectedCourse.number;
}
- (IBAction)addToCourseList:(id)sender 
{
    
    [CourseList addCourse: self.selectedCourse inSubject: selectedSubject];
    
    
    /*
    PFObject *courseToBeAdded = [PFObject objectWithClassName:@"CourseModel"];
    [courseToBeAdded setObject:[self.selectedCourse getNumber] forKey:@"number"];
    [courseToBeAdded setObject:[self.selectedSubject getAbbr] forKey:@"subject"];
    
    [courseToBeAdded save];
     */
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
//    [selectView setParentClassPicker:self];
    
    [self.navigationController presentModalViewController:selectView animated:YES];
    //[self presentModalViewController:selectView animated:YES];
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
    self.subjectLabel.text = self.selectedSubject.abbr;
    
    //subjectLabel.text = selectedSubject.abbr;
    
	// Do any additional setup after loading the view, typically from a nib.
    
  //  UIView *purpleView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f)]; 
    
 //   coursePicker = [UIPickerView initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 120.0f)];
//    purpleView.backgroundColor = [UIColor whiteColor]; // Assign the input view 
    
    tf2.inputView = coursePicker;
    
    
}

- (void)viewDidUnload
{
    [self setCoursePicker:nil];
    [self setTf2:nil];
    [self setSelectCourseButton:nil];
    [self setSubjectLabel:nil];
    [self setAddButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
