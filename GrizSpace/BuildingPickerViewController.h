//
//  BuildingPickerViewController.h
//  GrizSpace
//
//  Created by William Lyon and Kevin Scott on 3/1/12.
//  Copyright (c) 2012 University of Montana, Missoula MT. 
//  All rights reserved.
//
//  Description:  This View controller is used to search for a building to display on
//  the mapviewcontroller as an annotation.  This View controller also allows the user to search for
//  a building to find.



#import <UIKit/UIKit.h>
#import "DBAccess.h"
#import "BuildingModel.h"

@protocol MapViewControllerDelegate; //protocal to set the map annotations on the map.

@interface BuildingPickerViewController : UITableViewController
{
    NSMutableArray *copyListOfItems;
    BOOL searching;
    BOOL letUserSelectRow;
    IBOutlet UISearchBar *searchBar;
}

@property (nonatomic, weak) id<MapViewControllerDelegate> delegate; //delegate used to call mapview 

@end
