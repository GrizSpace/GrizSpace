//
//  ClassPickerViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCourseTableViewController.h"
#import "SubjectModel.h"


@interface ClassPickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *coursePicker;
@property (strong, nonatomic) IBOutlet UIButton *selectCourseButton;
@property (strong, nonatomic) SubjectModel* selectedSubject;

-(IBAction)showCoursesToSelect:(id)sender;
@end
