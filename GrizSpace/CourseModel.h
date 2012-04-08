//
//  CourseModel.h
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseSection.h"

@interface CourseModel : NSObject
{
 //this doesn't have to be done now?   
}

@property (nonatomic, assign)int idCourse;
@property (nonatomic, retain)NSString *number;
@property (nonatomic, assign)NSString *title;
@property (nonatomic, assign)NSString *subject_id;
@property (nonatomic, retain) NSString *subject;

@property (strong, nonatomic) NSString* instructorName;

@property (strong, nonatomic) NSString* days; //not used
@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSString* buildingAndRoom;
@property (strong, nonatomic) NSString* subjAbbr;

@property (assign, nonatomic) double longitude;

@property (assign, nonatomic) double latitude;

@property (assign, nonatomic) NSInteger radius;

@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) NSString* parseObjectID;

@property (strong, nonatomic) NSString* userid;

@property (strong, nonatomic) CourseSection* section;

-(void) setCourseSection: (CourseSection*) sectionToBeAdded;



// can delete all overwritten getters
-(NSString*) getTitle;
-(NSString*) getNumber;
-(NSString*) getSubject;
-(NSString*) getParseObjectID;
-(int) getIdCourse;

@end
