//
//  CourseModel.h
//  GrizSpace
//
//  Created by Jaylene Naylor on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CourseSection.h"
#import "SubjectModel.h"

@interface CourseModel : NSObject
{
 //this doesn't have to be done now?   
}

@property NSString* _title;

@property (nonatomic, assign)int idCourse;
@property (nonatomic, retain)NSString *number;
@property SubjectModel* subject;

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

-(id)initWithCourseId:(int)aCourseId
            andNumber:(NSString*)aNumber
             andTitle:(NSString*)aTitle
         andSubject:(SubjectModel*)aSubject;

// can delete all overwritten getters
-(NSString*) getTitle;
-(NSString*) getNumber;
-(NSString*) getParseObjectID;
-(int) getIdCourse;
-(NSString*) getShortName;

@end
