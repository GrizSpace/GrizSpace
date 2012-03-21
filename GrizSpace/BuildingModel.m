//
//  BuildingModel.m
//  DBConnectionPractice
//
//  Created by Jaylene Naylor on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuildingModel.h"



@implementation BuildingModel

@synthesize idBuilding;
@synthesize name = _name;
@synthesize fk_idGPS;

-(NSString*)getName
{
    return _name;
}

-(NSString*)getID
{
    return idBuilding;
}

@end
