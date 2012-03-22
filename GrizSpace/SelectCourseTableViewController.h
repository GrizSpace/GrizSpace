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

@interface SelectCourseTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (strong, nonatomic) NSMutableArray* courses;

-(IBAction)cancelButtonClicked:(id)sender;
@end
