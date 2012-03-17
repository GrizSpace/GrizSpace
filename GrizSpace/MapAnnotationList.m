//
//  MapAnnotationList.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapAnnotationList.h"
#import "MapAnnotation.h"


@implementation MapAnnotationList

@synthesize myAnnotationItems, currentAnnotationIndexSet;

-(id) init {
    self = [super init];  
    
    //setup default vars
    currentAnnotationIndexSet = false;
    myAnnotationItems = [[NSMutableArray alloc] init];
    currentAnnotationIndex = 0; 

    //create testing annotations
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.860917, -113.985968) title:@"Advanced Micro Economics 511" subtitle:@"LA 402" radius:100]];
     
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.861748, -113.985212) title:@"Intro to Java 101" subtitle:@"SS 352" radius:100]];
    
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.861779, -113.98633) title:@"Intro to English 152" subtitle:@"ENG 212" radius:100]];
  
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.860917, -113.985968) title:@"Intro to Art 122" subtitle:@"Art 312" radius:100]];
    
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.858891, -113.983798) title:@"Intro to Forestry 147" subtitle:@"For 302" radius:100]];
    
    [myAnnotationItems addObject: [[MapAnnotation alloc] initWithAnnotationDataKeyID:1 annotationType:@"Class" coordinate:CLLocationCoordinate2DMake(46.859325, -113.98566) title:@"Intro to Geometry 178" subtitle:@"Math 102" radius:100]];
    
    return self;
}

//gets the next class from the class list.
-(MapAnnotation*) GetNextAnnotation
{
    if(currentAnnotationIndex == ([myAnnotationItems count] - 1))
    {
        currentAnnotationIndex = 0;
    }
    else 
    {
        currentAnnotationIndex = currentAnnotationIndex + 1;
    }
    return self.GetCurrentAnnotation;
}

//gets the current annotation item.
-(MapAnnotation*) GetCurrentAnnotation
{
    return [myAnnotationItems objectAtIndex: currentAnnotationIndex];
}





@end
