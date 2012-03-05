//
//  ClassData.h
//  GrizSpace
//
//  Created by Kevin Scott on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDataObject.h"

//used to store class information for testing.
@interface ClassData : NSObject
{
    int classID;
    NSString* className;
    NSString* classNumber;
    NSString* classTitle;
    NSString* classPrefix;
    
    
    //testing vars to show class on map without complete structure.
    Float32 longitude;
    Float32 latitude;
}

//overloaded constructor.
- (id) initWithClassDataID: (int) tmpClassID Name:(NSString*) tmpClassName Number:(NSString*) tmpClassNumber Title:(NSString*) tmpClassTitle Prefix:(NSString*) tmpClassPrefix Lon:(Float32) tmpLon Lat:(Float32) tmpLat;


//Getters and setters for private vars.
@property (nonatomic, readwrite) int classID;
@property (nonatomic, readwrite) NSString* className;
@property (nonatomic, readwrite) NSString* classNumber;
@property (nonatomic, readwrite) NSString* classTitle;
@property (nonatomic, readwrite) NSString* classPrefix;

@property (nonatomic, readwrite) Float32 longitude;
@property (nonatomic, readwrite) Float32 latitude;

@end
