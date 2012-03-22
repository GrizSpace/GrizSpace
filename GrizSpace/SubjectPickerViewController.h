//
//  SubjectPickerViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "ClassPickerViewController.h"


@interface SubjectPickerViewController : UITableViewController
{
 //   UISearchBar* searchBar;
}

@property (nonatomic, strong) NSArray *subjects;
//@property (nonatomic, strong) UISearchBar *searchBar;
@end
