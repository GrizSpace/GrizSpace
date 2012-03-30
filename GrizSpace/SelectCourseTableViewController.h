//
//  SelectCourseTableViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "CourseModel.h"
#import "ClassPickerViewController.h"
@protocol CourseDelegate;

@interface SelectCourseTableViewController : UITableViewController// {__weak id <CourseDelegate> delegate;}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) NSMutableArray* courses;

@property (strong, nonatomic) SubjectModel* selectedSubject;

@property (nonatomic, weak) id<CourseDelegate> delegate;
//@property (strong, nonatomic) ClassPickerViewController* parentClassPicker;



-(IBAction)cancelButtonClicked:(id)sender;


//+(id)initWithSubject:(SubjectModel*)subj;

@end
