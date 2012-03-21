//
//  GPSModel.m
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPSModel.h"

@implementation GPSModel

@synthesize idGPS;
@synthesize Latitude;
@synthesize Longitude;
@synthesize Radius;



//finds a GPS model from the list.
+ (GPSModel*) FindGPSModelFromList: (NSMutableArray*) tmpGPSModelList idGPS: (NSInteger) searchIdGPS;
{
    for (GPSModel* tmpModel in tmpGPSModelList) {
        if(tmpModel.idGPS == searchIdGPS)
        {
            return tmpModel;
        }
    }
    return nil;
}

@end
