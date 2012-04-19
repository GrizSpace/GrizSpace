//
//  MapViewController.m
//  GrizSpace
//
//  Created by William Lyon and Kevin Scott on 3/1/12.
//  Copyright (c) 2012 University of Montana, Missoula MT. 
//
//  Description:  This View Controller is used to display a map, annotations, 
//    and additional functionalities for modifying the map.  Some of the functions 
//    include "shitching between map views and viewing a particular user class or list of classes.



#import "MapViewController.h"
#import "GrizSpaceDataObjects.h"
#import "AppDelegateProtocol.h"
#import "CourseDetailVewController.h"
#import "MapAnnotationView.h"

@interface MapViewController ()
    @property (nonatomic, retain) MapAnnotationCallout *calloutAnnotation;

@end



@implementation MapViewController


//retrieves the GrizeSpaceDataObjects for reference in the application
@synthesize myMapViewTypeSegmentControl;
@synthesize myMapAnnotationSegmentControl;
@synthesize myLocationCoordinate;
@synthesize DirectionCompas;
@synthesize distanceLabel;
@synthesize myLocationManager;
@synthesize mapView = _mapView;
@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize delegate;


//calculation used to transfer degree measurnments to radians.
#define degreesToRadians(x) (x * ((M_PI) / 180.0))
#define radiansToDegrees(x) (x * (180/M_PI))
/*
+ (float)degreesToRadians2:(float)degrees{
    return degrees / 57.2958;
    
}
*/

//used to store global information.
- (GrizSpaceDataObjects*) theAppDataObject
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	GrizSpaceDataObjects* theDataObject;
	theDataObject = (GrizSpaceDataObjects*) theDelegate.theAppDataObject;
	return theDataObject;
}
 

//init the view conroller
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

/*
***************
 Jester Regognition could be future functionality aka double tap map
 **************
//this handle gesture is the function call that gets called when double clicking on the map.
- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;

    CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
    CLLocationCoordinate2D touchMapCoordinate = [mapView convertPoint:touchPoint    toCoordinateFromView:mapView];
    
    NSString* messageString = [NSString stringWithFormat:@"Click Location %f : %f", touchMapCoordinate.longitude, touchMapCoordinate.latitude];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:messageString
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Ok", nil];
	[alert show];
}
*/

- (void)viewDidLoad 
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    distanceLabel.hidden = true;
    
    
    //define the action for the double tap process on the map.
    /*
     ***************
     Jester Regognition could be future functionality aka double tap map
     **************
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self        action:@selector(handleGesture:)];
    tgr.numberOfTapsRequired = 2;
    tgr.numberOfTouchesRequired = 1;
    [mapView addGestureRecognizer:tgr];
    */
    
    
    //mapview setup
    [self.view insertSubview:self.mapView atIndex:0];
    self.mapView.showsUserLocation = true;
    self.mapView.delegate = self;
    self.mapView.zoomEnabled = true;
    self.mapView.scrollEnabled = true;
    self.mapView.userInteractionEnabled = true; 
    self.mapView.mapType = MKMapTypeSatellite;
    
    //set the mapview segment selected index.
    myMapViewTypeSegmentControl.selectedSegmentIndex = 1;
 
    
    //location manager setup
    self.myLocationManager = [[CLLocationManager alloc] init];
    myLocationManager.delegate = self;
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    if( CLLocationManager.locationServicesEnabled && CLLocationManager.headingAvailable)        
    {
       
        [myLocationManager startUpdatingHeading];
    }
    else {
        NSLog(@"Can't report heading");
    }
    
    [myLocationManager startUpdatingLocation];
    
    
    //testing pretend we are in this location and set the view to here.
    myLocationCoordinate.latitude = 46.860900;
    myLocationCoordinate.longitude = -113.985188;
    
    //location updated so center to that location.
    MKCoordinateRegion myRegion;

    
    //set how zoomed in we are.
    MKCoordinateSpan mySpan;
    mySpan.latitudeDelta = 0.006;
    mySpan.longitudeDelta = 0.006;
    myRegion.span = mySpan;
    myRegion.center = myLocationCoordinate;
    [self.mapView setRegion:myRegion animated:true];  
    
    //segment annotation select action
    [self SegmentAnnotationSelect: nil];
}

- (void)viewDidUnload
{
    self.mapView = nil;
    myLocationManager = nil;
    myMapViewTypeSegmentControl = nil;
    myMapAnnotationSegmentControl = nil;
    [self setDirectionCompas:nil];
    [self setDistanceLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




//default to Porterate orientation all the time
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//when a Map view is changed this gets called
- (IBAction)SegmentMapViewSelect:(id)sender {
    
    //map view choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 0){
        self.mapView.mapType = MKMapTypeStandard;
    }
    
    //satalite choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 1){
        self.mapView.mapType = MKMapTypeSatellite;
        
    }
    
    //hybred choice
    if(myMapViewTypeSegmentControl.selectedSegmentIndex == 2){
        self.mapView.mapType = MKMapTypeHybrid;
        
    }
}

//when a annotation option is selected, this gets called.
- (IBAction)SegmentAnnotationSelect:(id)sender {
    
    //get the app data from teh griz space data objects ref.
    GrizSpaceDataObjects* theDataObject = [self theAppDataObject];
    
    distanceLabel.hidden = true;
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //add the current location to the map fly to area.
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    MKMapPoint annotationPoint = MKMapPointForCoordinate(myLocationCoordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);

    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
 
    //all classes
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){
        
        //get the users class items
        NSMutableArray* tmpMyClassArray = [[[self theAppDataObject] myCourses] getCourseListFromParse];
        
         

        
        //annotate all the classes on the map.
        for (CourseModel* tmpClass in tmpMyClassArray) {

            MapAnnotation* tmpMapAnn = [[MapAnnotation alloc] initWithCourseModel:tmpClass];
            
            bool matchFound = false;
            for(MapAnnotation *loopAnn in self.mapView.annotations)
            {
                if(tmpMapAnn.coordinate.latitude == loopAnn.coordinate.latitude && tmpMapAnn.coordinate.longitude == loopAnn.coordinate.longitude)
                {
                    [loopAnn.annObjectArray addObject:tmpMapAnn];
                    matchFound = true;
                    
                }
            }
            
            //no match add annotation
            if(matchFound == false)
            {
                
                annotationPoint = MKMapPointForCoordinate(tmpMapAnn.coordinate);
                pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
                
                //sets up the map annotation
                [self.mapView addAnnotation: tmpMapAnn];
                [self.mapView selectAnnotation: tmpMapAnn animated:YES];

                //ensure all annotations are visible in window.                
                if (MKMapRectIsNull(flyTo)) {
                    flyTo = pointRect;
                } else {
                    flyTo = MKMapRectUnion(flyTo, pointRect);
                }
            }
        }//end for
        
    }
    
    //next class
    if(myMapAnnotationSegmentControl.selectedSegmentIndex == 1){

        
        //gets the next class from the class data table.
        CourseModel* tmpClass = theDataObject.myCourses.GetNextCourse;
        if(tmpClass != nil)
        {
            //get the next annotation for the class
            MapAnnotation* tmpNextAnnotation = [[MapAnnotation alloc] initWithCourseModel:tmpClass];
            
            //define anotation point for map.
            MKMapPoint annotationPoint = MKMapPointForCoordinate(tmpNextAnnotation.coordinate);
            
            //place the annotation on the map.
            [self.mapView addAnnotation:tmpNextAnnotation];
            [self.mapView selectAnnotation:tmpNextAnnotation animated:YES];
            
            //define the bounding rectangle and set visible area to include annotation point.
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
            if (MKMapRectIsNull(flyTo)) {
                flyTo = pointRect;
            } else {
                flyTo = MKMapRectUnion(flyTo, pointRect);
            }
            
            //show the distance label
            distanceLabel.hidden = false;
        }
    }
    
    //clear map button event
    if(myMapAnnotationSegmentControl.selectedSegmentIndex != 2){
        //focus map to fly to area only if an annotation point is set.
        self.mapView.visibleMapRect = flyTo;
        
        
        if(myMapAnnotationSegmentControl.selectedSegmentIndex == 0){
            
            //expand fly to area a little if viewing all classes.
            MKCoordinateRegion myRegion;
            MKCoordinateSpan mySpan = self.mapView.region.span;
            mySpan.latitudeDelta = mySpan.latitudeDelta + .0002;
            mySpan.longitudeDelta = mySpan.longitudeDelta + .0002;
            myRegion.span = mySpan;
            myRegion.center = myLocationCoordinate;
            [self.mapView setRegion:myRegion animated:true];  
        }
        
 
        
    }
    
    //ensures that no segment is selected and annotation object is unset.
    [myMapAnnotationSegmentControl setSelectedSegmentIndex: UISegmentedControlNoSegment];
    annotationObject = Nil;
    
    
    
}




//gets the distance from the current class location to the next annotation spot if a single annotation is selected.
-(double) CalculateDistance:(double) lon1 Lat1:(double) lat1 Lon2:(double) lon2 Lat2: (double) lat2
{

    float d = 0;

    //((miles * feet * great circle) great arc distance formula.
    d = 3963.0 * 5280 * acos(sin(lat1/57.2958) * sin(lat2/57.2958) + cos(lat1/57.2958) * cos(lat2/57.2958) *  cos(lon2/57.2958 -lon1/57.2958));
    
    //ensure positive distance is returned
    if(d < 0)
    {
        d = d * -1;
    }        

    return d;
}

- (void)locationManager:(CLLocationManager*)manager didUpdateHeading:(CLHeading*)newHeading
{
    // If the accuracy is valid, process the event.
    if (newHeading.headingAccuracy > 0)
    {
        //find heading.
        CLLocationDirection theHeading = newHeading.magneticHeading;

        if(self.mapView.annotations.count == 2){ 
            CLLocation* startCord;
            CLLocation* destCord;
            int annotationAngle = 0;
            
            for(id<MKAnnotation> annotation in self.mapView.annotations)
            {
                if(annotation != self.mapView.userLocation) //set the destination cord.
                {
                    destCord = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
                }
                else //set the user location cord 
                {
                    startCord = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];    
                }
            }
  
            //find building angle to current location.
            float testY = (destCord.coordinate.latitude - startCord.coordinate.latitude); 
            float testX = (destCord.coordinate.longitude - startCord.coordinate.longitude); 
            testY = testY * -1;
            float annotationAngleRad = atan2f(testY, testX);        
            annotationAngle = floor(radiansToDegrees(annotationAngleRad));
            
            
            if(annotationAngle < 0) //third and fourth quards.
            {
                annotationAngle = 360 + annotationAngle;
            } 
            
            
            float theNewHeading = theHeading; // - 90;
            if(theNewHeading < 0)
            {
                theNewHeading = 360 + theNewHeading;
            }

            int diffAngle = annotationAngle - theNewHeading;

            float diffRad = degreesToRadians(diffAngle);
            DirectionCompas.transform = CGAffineTransformMakeRotation(diffRad);  
            
        }
    }
}


//fires every time the locatioin manager is updated.
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    myLocationCoordinate.latitude = newLocation.coordinate.latitude;
    myLocationCoordinate.longitude = newLocation.coordinate.longitude;
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    
    
    //identify the destinate annotation.
    CLLocation* destCord = newLocation;
    CLLocation* startCord = oldLocation;
    if(self.mapView.annotations.count == 2){    
        for(id<MKAnnotation> annotation in self.mapView.annotations)
        {
            if(annotation != self.mapView.userLocation)
            {
                startCord = newLocation;
                destCord = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
                
                //sets the distance label text.
                double distance = [self CalculateDistance:startCord.coordinate.longitude Lat1:startCord.coordinate.latitude Lon2: destCord.coordinate.longitude Lat2:destCord.coordinate.latitude];
                distanceLabel.text = [NSString stringWithFormat:@"Distance %.1lf ft", distance];
        
                //check if the user has arrived
                if([(MapAnnotation*)annotation arrived] == false)
                {
                    if ([annotation isKindOfClass:[MapAnnotation class]])
                    {
                        if(distance <= [(MapAnnotation*)annotation radius])
                        {
                            [(MapAnnotation*)annotation setArrived:true];
                            NSString* messageString = [[NSString alloc] initWithString:@"You have arrived at your at your location!  Now get to class :-)."];
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Destination Reached" message:messageString
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                        }
                    }
                }
                
            }
            
        }
        
        if(!(CLLocationManager.locationServicesEnabled && CLLocationManager.headingAvailable))       
        {
            //find building angle to current location.
            float testY = (destCord.coordinate.latitude - newLocation.coordinate.latitude); 
            float testX = (destCord.coordinate.longitude - newLocation.coordinate.longitude); 

            float annotationAngleRad = atan2f(testY, testX);        
            int annotationAngle = floor(radiansToDegrees(annotationAngleRad));
            
            
            if(annotationAngle < 0) //third and fourth quards.
            {
                annotationAngle = 360 + annotationAngle;
            }

            //find find angle of travel
            float headingY = newLocation.coordinate.latitude - oldLocation.coordinate.latitude; 
            float headingX = newLocation.coordinate.longitude - oldLocation.coordinate.longitude; 

            float headingAngleRad = atan2f(headingY, headingX);
            int headingAngle = floor(radiansToDegrees(headingAngleRad));
            
            
            if(headingAngle < 0) //third and fourth quards.
            {
                headingAngle = 360 + headingAngle;
            }

            int diffAngle = headingAngle;
            
            if(headingAngle > annotationAngle)
            {
                diffAngle = annotationAngle - headingAngle;
            }
            else if (headingAngle < annotationAngle) {
                diffAngle = headingAngle - annotationAngle;
            }
            float diffRad = degreesToRadians(diffAngle);
            DirectionCompas.transform = CGAffineTransformMakeRotation(diffRad);  
        }
        
    }
    else { //show current walking direction
        float dy = destCord.coordinate.latitude - startCord.coordinate.latitude;    
        float dx = destCord.coordinate.longitude - startCord.coordinate.longitude;
        dy = dy * -1;
        float directionAngleRad = atan2f(dy, dx);
        
        int directionAngle = floor(radiansToDegrees(directionAngleRad) + 90);
        
        
        if(directionAngle < 0) //third and fourth quards.
        {
            directionAngle = 360 + directionAngle;
        }
        
        float newDirAngRad = degreesToRadians(directionAngle);
        DirectionCompas.transform = CGAffineTransformMakeRotation(newDirAngRad);    
    }


    
    //if navigating to a class make sure both person and class are in map window.
    if(self.mapView.annotations.count == 2){
        //define the bounding rectangle and set visible area.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(newLocation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        flyTo = self.mapView.visibleMapRect;
        
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
        //self.mapView.visibleMapRect = flyTo;
    }   
    
    //only one annotation, center map here as this is usually the users location
    if(self.mapView.annotations.count == 1)
    {
        //location updated so center to that location.
        MKCoordinateRegion myRegion;
        
        //set how zoomed in we are.
        MKCoordinateSpan mySpan;
        mySpan.latitudeDelta = 0.006;
        mySpan.longitudeDelta = 0.006;
        myRegion.span = mySpan;
        myRegion.center = myLocationCoordinate;
        //[self.mapView setRegion:myRegion animated:true];  
    } 
}

- (void)mapView:(MKMapView *)mapView 
 annotationView:(MKAnnotationView *)view 
calloutAccessoryControlTapped:(UIControl *)control {
    annotationButtonActionTag = (long int)[control tag];
    
    //perform action for annotation.
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[MapAnnotation class]])
    {
        if(self.calloutAnnotation == nil)
        {
            self.calloutAnnotation = [[MapAnnotationCallout alloc] initWithMapAnnotation:view.annotation];
            
        }
        else 
        {
            [self.calloutAnnotation setMapAnnotation: view.annotation];
            
        }
        [self.mapView addAnnotation:self.calloutAnnotation];
		selectedAnnotationView = view;
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if(self.calloutAnnotation != nil)
    {
        [self.mapView removeAnnotation: self.calloutAnnotation];
    }
}



//creates the annotation display for the annoation that is being added to the map.
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    //if the annotation is the users location than return nil
    if (annotation == self.mapView.userLocation) return nil;

    
    if (annotation == self.calloutAnnotation) {
        MapAnnotationView *calloutMapAnnotationView = (MapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutAnnotation"];
		if (!calloutMapAnnotationView) {
			calloutMapAnnotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation 
                                                                                         reuseIdentifier:@"CalloutAnnotation"];

			
		}
		calloutMapAnnotationView.parentAnnotationView = selectedAnnotationView;
		calloutMapAnnotationView.mapView = self.mapView;
        [calloutMapAnnotationView clearAnnotations];
        
        [calloutMapAnnotationView addAnnotationModel:annotation];
        
		return calloutMapAnnotationView;

    }    
    else if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        
        //define the annotation pin
        MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier: @"mapPin"];
        
        //ensure the annotation pin is correctly defined.
        if (pin == nil)
        {
            pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"mapPin"];
        }
        else
        {
            pin.annotation = annotation;
        }
        
        MapAnnotation* tmpAnnRef = (MapAnnotation*) annotation;
        if ( tmpAnnRef.annObjectArray.count > 2) {
            pin.pinColor = MKPinAnnotationColorPurple;
        }
        else if (tmpAnnRef.annObjectArray.count > 1) {
            pin.pinColor = MKPinAnnotationColorGreen;
        }
        else {
            pin.pinColor = MKPinAnnotationColorRed;
        }

        pin.rightCalloutAccessoryView = nil;

        [pin setEnabled:YES];
        [pin setCanShowCallout:NO];
        return pin;
        
    }

    return nil;
}

//action for annotation object click event.
-(void) buttonClicked:(UIButton*) button
{
    annotationButtonActionTag = (long int)[button tag];
    
    //perform action for annotation.
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];
    
    
}

//action for annotation object click event.
-(void) buttonSearchClicked:(UIButton*) button
{
    annotationButtonActionTag = (long int)[button tag];
    
    //perform action for annotation.
    [self performSegueWithIdentifier:@"MapToCourseDetail" sender:self];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqualToString:@"MapToCourseDetail"])
    {
        // Get reference to the destination view controller
        CourseDetailVewController *cDVC = [segue destinationViewController];
        
        cDVC.courseIndex = annotationButtonActionTag;
        if(annotationObject != Nil &&  ([annotationObject isKindOfClass:[CourseModel class]]))
        {
            [cDVC setSelectedCourse:(CourseModel*)annotationObject]; 
        }
        else {
            [cDVC setSelectedCourse:[[[[self theAppDataObject] myCourses] getCourseListFromParse]   objectAtIndex:annotationButtonActionTag]];
            annotationObject = Nil;
        }
    }
     
}

//function used to show all annotations on the map.
-(void)setAnnotationsSegmentIndex: (int) newSegmentIndex
{
    myMapAnnotationSegmentControl.selectedSegmentIndex = newSegmentIndex;
    [self SegmentAnnotationSelect: nil];
}

//function used to show all annotations on the map.
-(void)showBuildingAnnotation: (int) newBuildingIndex
{

    BuildingModel* newBuilding = [[self theAppDataObject].buildings objectAtIndex:newBuildingIndex];
    
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    tmpAnn = [[MapAnnotation alloc] initWithBuildingModel:newBuilding];
    
    //add the current location to the map fly to area.
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    MKMapPoint annotationPoint = MKMapPointForCoordinate(myLocationCoordinate);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
    
    //define anotation point for map.
    annotationPoint = MKMapPointForCoordinate(tmpAnn.coordinate);
    
    //place the annotation on the map.
    [self.mapView addAnnotation:tmpAnn];
    [self.mapView selectAnnotation:tmpAnn animated:YES];

    //define the bounding rectangle and set visible area to include annotation point.
    pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
    if (MKMapRectIsNull(flyTo)) {
        flyTo = pointRect;
    } else {
        flyTo = MKMapRectUnion(flyTo, pointRect);
    }
    
    
    //set visible rectngle
    self.mapView.visibleMapRect = flyTo;
    
    //show the distance label
    distanceLabel.hidden = false;
}

-(void)showCourseAnnotation: (NSObject*) tmpClass
{
    //we can auto call option 2 to remove annotations befor another needs to be drawn.
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKMapRect flyTo = MKMapRectNull; //map bounding rectangle for classes.
    
    if ([tmpClass isKindOfClass:[CourseModel class]])
    {
        //get the next annotation for the class
        MapAnnotation* tmpNextAnnotation = [[MapAnnotation alloc] initWithSearchCourseModel:(CourseModel*)tmpClass];
        
        annotationObject = tmpClass;
        
        //define anotation point for map.
        MKMapPoint annotationPoint = MKMapPointForCoordinate(tmpNextAnnotation.coordinate);
        
        //place the annotation on the map.
        [self.mapView addAnnotation:tmpNextAnnotation];
        [self.mapView selectAnnotation:tmpNextAnnotation animated:YES];
        
        //define the bounding rectangle and set visible area to include annotation point.
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
        
        //show the distance label
        distanceLabel.hidden = false;
    }
}




@end
