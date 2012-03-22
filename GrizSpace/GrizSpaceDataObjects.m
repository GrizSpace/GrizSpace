//
//  GrizSpaceDataObjects.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrizSpaceDataObjects.h"
#import "DBAccess.h"


@implementation GrizSpaceDataObjects

@synthesize myMapAnnotationList, buildings;

//default constructor
-(id) init {
    self = [super init];
    myMapAnnotationList = [[MapAnnotationList alloc] init];
    buildings = [[NSMutableArray alloc] init];
 
    
     //sets up the buildings for reference.
     DBAccess *dbAccess = [[DBAccess alloc] init];
     self.buildings = [dbAccess.getAllBuildings mutableCopy];
     [dbAccess closeDatabase];
     
    
    
    return self;
}


@end
