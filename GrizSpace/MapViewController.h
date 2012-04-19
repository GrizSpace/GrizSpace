//
//  MapViewController.h
//  GrizSpace
//
//  Created by William Lyon and Kevin Scott on 3/1/12.
//  Copyright (c) 2012 University of Montana, Missoula MT. 
//
//  Description:  This View Controller is used to display a map, annotations, 
//    and additional functionalities for modifying the map.  Some of the functions 
//    include "shitching between map views and viewing a particular user class or list of classes.



#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BuildingModel.h"
#import "MapAnnotation.h"
#import "MapAnnotationCallout.h"
//used for accing and setting the map properties
@protocol MapViewControllerDelegate
-(void)setAnnotationsSegmentIndex: (int) newSegmentIndex; //sets map annotation segment index
-(void)showBuildingAnnotation: (int) newBuildingIndex; //sets the map annotation to the building input
-(void)showCourseAnnotation: (NSObject*) newCourse; //sets the course annotation to the course. 
@end
@protocol CourseDetailControllerDelegate; //protocal to set the cours details item to display.

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate, MapViewControllerDelegate> 
{
    MapAnnotation* tmpAnn;
    long int annotationButtonActionTag; //the action tag associated with the page button annotation action.
    
    NSObject* annotationObject; //the current set annotation object.
    
   	MapAnnotationCallout *_calloutAnnotation;
    MKAnnotationView *selectedAnnotationView;
    MKMapView *_mapView;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (nonatomic, weak) id<CourseDetailControllerDelegate> delegate; //delegate used to call course details 


//used for switching between the different segments for map, hybrid, and satalite
@property (weak, nonatomic) IBOutlet UISegmentedControl *myMapViewTypeSegmentControl;

//Used for swiching between the annotation options for View all classes, next class, and clear map.
@property (weak, nonatomic) IBOutlet UISegmentedControl *myMapAnnotationSegmentControl;

//reference to the location manager for the map to identify current location
@property (nonatomic, retain) CLLocationManager *myLocationManager; 

//the location cordinate for the current location on the map.
@property (nonatomic, readonly) CLLocationCoordinate2D myLocationCoordinate; 

//used for updating the compas for directions for next class
@property (weak, nonatomic) IBOutlet UIImageView *DirectionCompas;

//text used for updating the distance displayed on map.
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;




@end
