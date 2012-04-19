//
//  CourseModel.m
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseModel.h"

@implementation CourseModel

@synthesize _title;
@synthesize idCourse;
@synthesize number;
@synthesize subject;
@synthesize instructorName;

@synthesize buildingAndRoom;
@synthesize days;
@synthesize time;
@synthesize subjAbbr;
@synthesize longitude;
@synthesize latitude;
@synthesize radius;
@synthesize index;
@synthesize parseObjectID;
@synthesize userid;
@synthesize section;


-(id)initWithCourseId:(int)aCourseId
            andNumber:(NSString*)aNumber
             andTitle:(NSString*)aTitle
         andSubject:(SubjectModel*)aSubject
{
    self = [super init];

    if (!self)
        return nil;

    self.idCourse = aCourseId;
    self.number   = aNumber;
    self._title   = aTitle;
    self.subject  = aSubject;

    return self;

}

-(void) setCourseSection:(CourseSection *)sectionToBeAdded
{
    section = sectionToBeAdded;
}

-(NSString*)getTitle
{
    return self._title;
}

-(NSString*) getNumber
{
    return number;
}

-(NSString*) getParseObjectID
{
    return parseObjectID;
}

-(int) getIdCourse
{
    return idCourse;
}

-(NSString*)getShortName
{
    return [NSString stringWithFormat:@"%@ %@", [subject abbr], number];
}

@end

