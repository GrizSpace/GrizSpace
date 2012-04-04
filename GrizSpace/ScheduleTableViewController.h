//
//  ScheduleTableViewController.h
//  GrizSpace
//
//  Created by Jaylene Naylor on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CourseList.h"
#import "CourseDetailVewController.h"

@interface ScheduleTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *courses;
@property (nonatomic, strong) NSArray *dayTimes;
@property (nonatomic, strong) NSMutableArray *myCourses;
@end
