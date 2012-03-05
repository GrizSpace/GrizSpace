//
//  ClassData.m
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClassData.h"

@implementation ClassData
@synthesize classID, className, classNumber, classPrefix, classTitle;


@synthesize longitude, latitude;

//overloaded constructor.
- (id) initWithClassDataID: (int) tmpClassID Name:(NSString*) tmpClassName Number:(NSString*) tmpClassNumber Title:(NSString*) tmpClassTitle Prefix:(NSString*) tmpClassPrefix Lat:(double) tmpLat Lon:(double) tmpLon
{
    if (self = [super init])
    {
        [self setClassID:tmpClassID];
        [self setClassName:tmpClassName];
        [self setClassNumber:tmpClassNumber];
        [self setClassTitle:tmpClassNumber];
        [self setClassPrefix:tmpClassPrefix];
        [self setLongitude:tmpLon];
        [self setLatitude:tmpLat];
    }
    return self;
}

//default constructor
-(id) init {
    //call overloaded contructor to ensure initialization of data
    return [self initWithClassDataID:0 Name:@"" Number:@"" Title:@"" Prefix:@"" Lat:0 Lon:0 ];
}

@end
