//
//  BuildingPickerViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "BuildingModel.h"

@interface BuildingPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *buildings;

//@property (nonatomic, strong) DBAccess* database;
@end
