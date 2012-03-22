//
//  SelectCourseTableViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCourseTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

-(IBAction)cancelButtonClicked:(id)sender;
@end
