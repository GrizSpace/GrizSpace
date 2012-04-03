//
//  CourseListViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "CourseList.h"
#import "CourseDetailVewController.h"



@protocol MapViewControllerDelegate; //protocal to set the map annotations on the map.
@protocol CourseDelegate;

@interface CourseListViewController : UITableViewController 
@property (nonatomic, strong) NSArray *courses;
@property (nonatomic, strong) NSArray *dayTimes;
@property (nonatomic, weak) id<MapViewControllerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *myCourses;

@property (nonatomic, weak) id<CourseDelegate> courseDelegate;


//delegate used to call mapview function for setting annotations.
//-(void) SelectRowAtIndex:(int)rowIndex;

@end
