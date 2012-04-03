//
//  CourseModel.m
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel

@synthesize idCourse;
@synthesize number;
@synthesize title;
@synthesize subject_id;
@synthesize subject;
@synthesize instructorName;
@synthesize days;
@synthesize time;
@synthesize buildingAndRoom;
@synthesize subjAbbr;

@synthesize longitude;
@synthesize latitude;
@synthesize radius;
@synthesize index;
@synthesize parseObjectID;
@synthesize userid;
@synthesize section;

/*
-(void) setCourseSection:(CourseSection *)sectionToBeAdded
{
    
}
*/

-(NSString*) getTitle
{

return title;
}

-(NSString*) getNumber
{
    return number;
}

-(NSString*) getSubject
{
    return subject;
}

-(NSString*) getParseObjectID
{
    return parseObjectID;
}

@end

