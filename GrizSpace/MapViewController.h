//
//  MapViewController.h
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
//#import "GrizSpaceDataObjects.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> 
{
    __weak IBOutlet MKMapView *mapView;

    CLLocationManager *myLocationManager; //used for updating and tracking the movment of my location
    CLLocationCoordinate2D myLocationCoordinate; //used for storing 2d location cordinates.
    //GrizSpaceDataObjects* theDataObject; //objects reference to data 
    
}

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
@property (weak, nonatomic) IBOutlet UITextField *distanceText;

//function used to calculate distance between annotation points.
//-(double) CalculateDistance:(double) lon1 Lat1:(double) lat1 Lon2:(double) lon2 Lat2:(double) lat2;
@end
