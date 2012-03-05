//
//  MapViewController.m
//  GrizSpace
//
//  Created by William Lyon on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "GrizSpaceDataObjects.h"
#import "AppDelegateProtocol.h"
#import "ClassData.h"
#import "ClassTable.h"
#import "MapAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController


//retrieves the GrizeSpaceDataObjects for reference in the application
@synthesize myMapViewTypeSegmentControl;
@synthesize myMapAnnotationSegmentControl;
@synthesize myLocationCoordinate;
@synthesize myLocationManager;


- (GrizSpaceDataObjects*) theAppDataObject;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    //mapview setup
    [self.view insertSubview:mapView atIndex:0];
    mapView.showsUserLocation = true;
    mapView.delegate = self;
    mapView.zoomEnabled = true;
    mapView.scrollEnabled = true;
    mapView.userInteractionEnabled = true;
    mapView.mapType = MKMapTypeSatellite;
    
    //set the mapview segment selected index.
    myMapViewTypeSegmentControl.selectedSegmentIndex = 1;
    
    //clear map segment set by default
    myMapAnnotationSegmentControl.selectedSegmentIndex = 2;
    
    
    //location manager setup
    self.myLocationManager = [[CLLocationManager alloc] init];
    myLocationManager.delegate = self;
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    [myLocationManager startUpdatingLocation];
    [myLocationManager startUpdatingHeading];
    
    
    //testing pretend we are in this location and set the view to here.
    myLocationCoordinate.latitude = 46.860900;
    myLocationCoordinate.longitude = -113.985188;
    
    //location updated so center to that location.
    MKCoordinateRegion myRegion;
    //only set the default location one time.
    
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    
    //set how zoomed in we are.
    
    myRegion.span = mySpan;
    
    
    myRegion.center = myLocationCoordinate;
    [mapView setRegion:myRegion animated:true];  
    
    
}

- (void)viewDidUnload
{
    mapView = nil;
    myLocationManager = nil;
    myMapViewTypeSegmentControl = nil;
    myMapAnnotationSegmentControl = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//when a Map view is changed this gets called
- (IBAction)SegmentMapViewSelect:(id)sender {
    
    //map view choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 0){
        mapView.mapType = MKMapTypeStandard;
    }
    
    //satalite choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 1){
        mapView.mapType = MKMapTypeSatellite;
        
    }
    
    //hybred choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 2){
        mapView.mapType = MKMapTypeHybrid;
        
    }
    
    
}

//when a annotation option is selected, this gets called.
- (IBAction)SegmentAnnotationSelect:(id)sender {
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [mapView removeAnnotations:mapView.annotations];
    
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    //get teh class table
    ClassTable* tmpClassTable = [theDataObject GetClassTable];
    
    NSMutableArray* tmpClassDataArray = [tmpClassTable GetClassItems];
    
    
    //all classes
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){
        
        
        //MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
        
        //annotate all the classes on the map.
        for (ClassData* tmpCD in tmpClassDataArray) {
            
            CLLocationCoordinate2D theCoordinate1;
            theCoordinate1.latitude = [tmpCD latitude];
            theCoordinate1.longitude = [tmpCD longitude];
            
            //MKMapPoint annotationPoint = MKMapPointForCoordinate(theCoordinate1);
            //MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            
            //sets up the map annotation
            MapAnnotation* ann = [[MapAnnotation alloc] init];
            ann.title = [tmpCD className];
            ann.coordinate = theCoordinate1;
            [mapView addAnnotation:ann];
            [mapView selectAnnotation:ann animated:YES];
            
            NSLog(@"Annotation set %@ Lon:%f Lat%f",tmpCD.className, theCoordinate1.latitude, theCoordinate1.longitude);
            //ensure all annotations are visible in window.
            /*
            if (MKMapRectIsNull(flyTo)) {
                flyTo = pointRect;
            } else {
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
            */
        }
        //mapView.visibleMapRect = flyTo;
        
        
        
    }
    
    //next class
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 1){

        //gets the next class from the class data table.
        ClassData* tmpNextClass = [tmpClassTable GetNextClass];
              
        //sets the cordinate for the annotation.
        CLLocationCoordinate2D theCoordinate1;
        theCoordinate1.latitude = [tmpNextClass latitude];
        theCoordinate1.longitude = [tmpNextClass longitude];
        
        //define rectangle for anotation point
        //MKMapPoint annotationPoint = MKMapPointForCoordinate(theCoordinate1);
        
        //MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        //mapView.visibleMapRect = pointRect;
        
        //sets up the map annotation
        MapAnnotation* ann = [[MapAnnotation alloc] init];
        ann.title = [tmpNextClass className];
        ann.coordinate = theCoordinate1;
        [mapView addAnnotation:ann];
        [mapView selectAnnotation:ann animated:YES];
        
        NSLog(@"Annotation set %@ Lon: %f Lat: %f",tmpNextClass.className, theCoordinate1.latitude, theCoordinate1.longitude);
        
        //clear then selection so next class can be pushed again.
        myMapAnnotationSegmentControl.selectedSegmentIndex = 2;        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"New magnetic heading: %f", newHeading.magneticHeading);
    NSLog(@"New true heading: %f", newHeading.trueHeading);
}





@end
