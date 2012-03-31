//
//  ClassPickerViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SelectCourseTableViewController.h"
#import "SubjectModel.h"
#import "CourseModel.h"
#import "CourseList.h"

@protocol CourseDelegate

-(void) didReceiveCourse:(CourseModel*) selectedCourseFromPicker;

@end

@interface ClassPickerViewController : UIViewController<CourseDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectCourseButton;
@property (strong, nonatomic) SubjectModel* selectedSubject;
@property (strong, nonatomic) CourseModel* selectedCourse;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

-(IBAction)showCoursesToSelect:(id)sender;
@end
