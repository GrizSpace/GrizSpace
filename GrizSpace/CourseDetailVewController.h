//
//  CourseDetailVewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



//used for accing and setting the map properties
@protocol CourseDetailControllerDelegate
-(void) LoadCourseDetails; //used to display details about a course.
@end

@interface CourseDetailVewController : UIViewController <CourseDetailControllerDelegate>
{
    __weak IBOutlet UILabel *courseSubjectNumber;
    
    __weak IBOutlet UILabel *courseTitle;
    
    __weak IBOutlet UILabel *courseDays;
    
    __weak IBOutlet UILabel *courseTime;
    
    __weak IBOutlet UILabel *courseRoom;
    
    
}

@property (nonatomic, readwrite) int courseIndex;

@end
