//
//  MapAnnotationView.h
//  GrizSpace
//
//  Created by Kevin Scott on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotationCallout.h"

@interface MapAnnotationView : MKAnnotationView
{
    MKAnnotationView *_parentAnnotationView;
    MKMapView *_mapView;
    CGRect _endFrame;
    UIView *_contentView;
    CGFloat _yShadowOffset;
    CGPoint _offsetFromParent;
    CGFloat _contentHeight;
    NSMutableArray* buttonList;
    UIButton* currButton;
    NSMutableArray* annotationsList;
    MapAnnotationCallout* currAnn;
    int currButtonIndex;
}



@property (nonatomic, retain) MKAnnotationView *parentAnnotationView;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic) CGPoint offsetFromParent;
@property (nonatomic) CGFloat contentHeight;


- (void)animateIn;
- (void)animateInStepTwo;
- (void)animateInStepThree;
- (void) addAnnotationModel: (MapAnnotationCallout*) tmpAM;
- (void) clearAnnotations;


@end
