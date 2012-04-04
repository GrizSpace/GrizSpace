//
//  CourseDetailVewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "CourseModel.h"
#import "CourseSection.h"

// ignore CourseDelegate protocol/delegate - that is not needed and will be deleted

//used for accing and setting the map properties
@protocol CourseDetailControllerDelegate
-(void) LoadCourseDetails; //used to display details about a course.
@end

@protocol CourseDelegate

-(void) didReceiveCourse:(CourseModel*) selectedCourseFromPicker;

@end


@interface CourseDetailVewController : UIViewController <CourseDelegate,
CourseDetailControllerDelegate>
{
    __weak IBOutlet UILabel *courseSubjectNumber;
    
    __weak IBOutlet UILabel *courseTitle;
    
    __weak IBOutlet UILabel *courseDays;
    
    __weak IBOutlet UILabel *courseTime;
    
    __weak IBOutlet UILabel *courseRoom;
    
    
}

@property (nonatomic, readwrite) int courseIndex;
@property (nonatomic, weak) id<CourseDelegate> courseDelegate;


@property (nonatomic, strong) CourseModel* selectedCourse;



@end
