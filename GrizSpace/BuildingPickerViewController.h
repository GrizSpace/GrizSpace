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
@protocol MapViewControllerDelegate; //protocal to set the map annotations on the map.

@interface BuildingPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *buildings;


@property (nonatomic, weak) id<MapViewControllerDelegate> delegate; //delegate used to call mapview 
//@property (nonatomic, strong) DBAccess* database;
@end
