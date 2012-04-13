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
#import "SelectSectionTableViewController.h"
#import "SubjectModel.h"
#import "CourseModel.h"
#import "CourseList.h"
#import "CourseSection.h"
#import "MapViewController.h"


@protocol MapViewControllerDelegate; //protocal to set the map annotations on the map.

@protocol CourseDelegate

-(void) didReceiveCourse:(CourseModel*) selectedCourseFromPicker;

@end

@protocol sectionDelegate 

-(void) didReceiveSection:(CourseSection*) selectedSectionFromPicker;
@end

@interface ClassPickerViewController : UIViewController<CourseDelegate, sectionDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectCourseButton;
@property (strong, nonatomic) SubjectModel* selectedSubject;
@property (strong, nonatomic) CourseModel* selectedCourse;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, weak) id<MapViewControllerDelegate> delegate; //delegate used to call mapview 


-(IBAction)showCoursesToSelect:(id)sender;
@end
