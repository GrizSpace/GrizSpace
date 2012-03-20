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
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) UISearchDisplayController* searchController;

@property (nonatomic, strong) NSMutableArray *buildings;

@property (nonatomic, strong) NSArray* filteredBuildings;

//@property (nonatomic, strong) DBAccess* database;
@end
