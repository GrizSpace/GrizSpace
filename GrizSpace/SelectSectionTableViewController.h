//
//  SelectSectionTableViewController.h
//  GrizSpace
//
//  Created by William Lyon on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseSection.h"
#import "CourseModel.h"
#import "ClassPickerViewController.h"
#import "CourseSectionMapper.h"
#import "SubjectModel.h"
#import "ClassPickerViewController.h"

@protocol sectionDelegate;

@interface SelectSectionTableViewController : UITableViewController

@property (nonatomic, weak) id<sectionDelegate> sectiondelegate;
@property (nonatomic, strong) NSArray* sections;
@property (nonatomic, strong) CourseModel* selectedCourse;
@property (nonatomic, strong) SubjectModel* selectedSubject; // subjetModel should be added as property in CourseModel - for refactor

@end
