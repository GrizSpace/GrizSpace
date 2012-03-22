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


//used for accing and setting the map properties
@protocol MapViewControllerDelegate

-(void)setAnnotationsSegmentIndex: (int) newSegmentIndex; //sets map annotation segment index
-(void)showBuildingAnnotation:(int) newBuildingIndex; //sets the map annotation to the building index
@end

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UITabBarControllerDelegate, MapViewControllerDelegate> 
{
    __weak IBOutlet MKMapView *mapView; //reference to the private mapview

    long int annotationButtonActionTag; //the action tag associated with the page button annotation action.
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
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;




@end
